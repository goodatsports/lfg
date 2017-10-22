class Game < ApplicationRecord
  has_many :user_games
  has_many :users, through: :user_games

  def has_association?(user)
    if (UserGame.find_by(user_id: user.id, game_id: self.id))
      return true
    else false
    end
  end
end
