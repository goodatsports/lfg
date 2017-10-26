# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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