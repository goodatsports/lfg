class RemoveUniqueIndexFromUserGame < ActiveRecord::Migration[5.1]
  def change
    remove_index :user_games, column: [ :user_id, :game_id ]
  end
end
