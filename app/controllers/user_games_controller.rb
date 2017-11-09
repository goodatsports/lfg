class UserGamesController < ApplicationController
  def create
    usergame = UserGame.new(user_id: current_user.id, game_id: params[:game_id])
    if usergame.save
      redirect_to "/users/#{session[:user_id]}"
    else 
      flash[:warning] = "You're already following this game!"
      redirect_to "/games/#{params[:game_id]}"
    end
  end

  def index
    @games = current_user.games
  end

  def new
    @steam_games = Unirest.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{current_user.steam_id}&include_appinfo=1&format=json").body['response']['games']
    @game_titles = @steam_games.map {|game| game['name']}
  end
end
