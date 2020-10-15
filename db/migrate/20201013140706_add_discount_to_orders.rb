class AddDiscountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :discount, :integer
  end
end
