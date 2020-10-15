class AddDiscountToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :discount, :float
  end
end
