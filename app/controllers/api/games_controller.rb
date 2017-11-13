class Api::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @games = Game.all
    render 'index.json.jbuilder'
  end

  def create
    current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    games = params[:games]
    games.each do |game|
      local_game = Game.find_by(title: game)
      if local_game
        UserGame.create(user_id: current_user.id, game_id: local_game.id)
        puts "GAME SAVED"
      else
        new_game_id = Unirest.get("#{ENV['API_URL']}/games/?search=#{game}", headers:{ "Accept" => "application/json", "user-key" => ENV['API_KEY']}).body[0]['id']
        puts "RESPONSE: #{new_game_id}"

        new_game = Unirest.get("#{ENV['API_URL']}/games/#{new_game_id}?fields=*", headers:{ "Accept" => "application/json", "user-key" => ENV['API_KEY']}).body[0]
        puts "RESPONSE: #{new_game}"
          # Grab image id from cover image in API call
        if new_game['cover']
          image_id = new_game['cover']['cloudinary_id']
        else image_id = "0"
        end 
       new_game = Game.create(
          title: new_game['name'],
          api_id: new_game['id'],
          popularity: new_game['popularity'],
          #Form image url using image ID 
          image_url: "#{ENV['IMG_URL']}/t_cover_big/#{image_id}.jpg")
        UserGame.create(user_id: current_user.id, game_id: new_game.id)
      end
    end
    flash[:success] = "Steam library successfully imported!"
    render :json => {response: "OK"}
  end

  def show
    @game = Game.find_by(id: params[:id])
    if(!@game)
      @game = Game.create(api_id: params[:id], id: params[:id])
    end

    # API call to IGDB for Game page
    @response = (Unirest.get "#{ENV['API_URL']}/games/#{@game.api_id}", headers:{ "Accept" => "application/json", "user-key" => ENV['API_KEY']}).body[0]

    genre_ids = @response["genres"]

    # Get game's ID used by IGDB for images
    image_id = @response["cover"]["cloudinary_id"]
    # Form image url using image ID 
    @cover = "#{ENV['IMG_URL']}/t_cover_big/#{image_id}.jpg"

    @genres = []
    # API call to IGDB for Genres
    genre_ids.each do |genre_id|
      res = Unirest.get "#{ENV['API_URL']}/genres/#{genre_id}", headers:{ "Accept" => "application/json", "user-key" => ENV['API_KEY']}
      @genres << res.body[0]["name"]
    end

    # Update backend if game is not already in local database
    if (@game.title != @response["name"].to_s)
      Game.update(@game.id, title: @response["name"])
    end
  end
end
