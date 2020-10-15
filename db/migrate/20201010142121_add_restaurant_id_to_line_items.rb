class AddRestaurantIdToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :restaurant_id, :integer
  end
end
