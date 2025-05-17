class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.text :wine_menu
      t.string :restaurant_name

      t.timestamps
    end
  end
end
