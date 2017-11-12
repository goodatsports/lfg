class Api::UsersController < ApplicationController

  def show_current
    @user = current_user
    render 'user.json.jbuilder'
  end

  def steam_library
    @user = current_user
    @steam_library = Unirest.get("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{@user.steam_id}&include_appinfo=1&format=json").body['response']['games']
    @steam_library.each do |game|
      game['img_logo_url'] = "http://media.steampowered.com/steamcommunity/public/images/apps/#{game['appid']}/#{game['img_logo_url']}.jpg";
    end
  end
end
