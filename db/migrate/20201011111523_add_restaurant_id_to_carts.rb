class AddRestaurantIdToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :restaurant_id, :integer
  end
end
