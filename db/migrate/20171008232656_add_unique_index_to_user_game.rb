class AddUniqueIndexToUserGame < ActiveRecord::Migration[5.1]
  def change
    add_index :user_games, [ :user_id, :game_id ], :unique => true, :name => 'by_id_and_game'

  end
end
