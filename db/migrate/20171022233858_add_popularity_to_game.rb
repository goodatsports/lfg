class AddPopularityToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :popularity, :float
  end
end
