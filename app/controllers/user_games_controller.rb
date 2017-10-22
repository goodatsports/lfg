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
end
