class AddRestaurantIdToDish < ActiveRecord::Migration[6.0]
  def change
    add_column :dishes, :restaurant_id, :integer
  end
end
