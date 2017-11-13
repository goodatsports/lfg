## Seed Users table
user = User.create(
  nickname: "angus",
  email: "ang@us.com",
  password_digest: BCrypt::Password.create("1"),
  bio: "hey")

50.times do
  new_user = User.new(
    nickname: "#{Faker::Hipster.word}_#{Faker::Name.first_name.downcase}")
  new_user.update(
    email: "#{new_user.nickname}@gmail.com",
    password: BCrypt::Password.create(new_user.id),
    bio: "#{Faker::Hipster.paragraph}")
  new_user.save
end


## Seed Game database
limit = 49
offset = 0

4.times do 
  new_games = Unirest.get("#{ENV['API_URL']}/games/?fields=id,name,popularity,cover&order=popularity:desc&limit=#{limit}&offset=#{offset}", headers:{ "Accept" => "application/json", "user-key" => ENV['API_KEY']}).body
  new_games.each do |game|
  # Grab image id from cover image in API call
    if game['cover']
      image_id = game['cover']['cloudinary_id']
    else image_id = "0"
    end 
    Game.create(
      title: game['name'],
      api_id: game['id'],
      popularity: game['popularity'],
      #Form image url using image ID 
      image_url: "#{ENV['IMG_URL']}/t_cover_big/#{image_id}.jpg")
  end
  offset = offset + limit
end


# Seed associations between users and games
300.times do
  uid = Random.rand(User.count - 1) + 1
  # Ensure test user has no game associations
  while uid == 1
    uid = Random.rand(User.count - 1) + 1
  end

  user_game = UserGame.create(
    user_id: uid,
    game_id: Random.rand(Game.count - 1) + 1)
end

