class GamesController < ApplicationController
  def index
    @games = Game.all
    render :index
  end

  def show
    @game = Game.find_by(api_id: params[:id])
    render :show
  end
end
