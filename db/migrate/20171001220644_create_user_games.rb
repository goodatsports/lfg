class CreateUserGames < ActiveRecord::Migration[5.1]
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.datetime :end_time

      t.timestamps
    end
  end
end