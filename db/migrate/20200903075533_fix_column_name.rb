class FixColumnName < ActiveRecord::Migration[6.0]
  def self.up
    rename_column :line_items, :product_id, :dish_id
  end
end
