class ReplaceRestaurantWithRestaurantIdInSessions < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing string column
    remove_column :sessions, :restaurant, :string

    # Add the new restaurant_id column with a foreign key constraint
    add_reference :sessions, :restaurant, foreign_key: true
  end
end
