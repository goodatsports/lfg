class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(id: params[:id])

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
  end
end
