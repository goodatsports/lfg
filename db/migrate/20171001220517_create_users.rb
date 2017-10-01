class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password
      t.string :bio
      t.string :steam_id
      t.string :discord_id
      t.string :image_url

      t.timestamps
    end
  end
end
