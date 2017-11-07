class User < ApplicationRecord
  has_secure_password
  has_many :user_games
  has_many :games, through: :user_games

   #def from_omniauth(auth)

    #info = auth['info']
    # Convert from 64-bit to 32-bit
    #current_user.steam_id = auth['uid']
    #current_user.nickname = info['nickname']
    #user.avatar_url = info['image']
    #user.profile_url = info['urls']['Profile']
    #user.save!
    #user
  #end

end
