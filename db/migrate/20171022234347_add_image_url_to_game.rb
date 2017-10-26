class AddImageUrlToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :image_url, :string
  end
end
