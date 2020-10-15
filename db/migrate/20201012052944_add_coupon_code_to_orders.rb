class AddCouponCodeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :coupon_code, :string
  end
end
