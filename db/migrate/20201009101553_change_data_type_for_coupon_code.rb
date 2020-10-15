class ChangeDataTypeForCouponCode < ActiveRecord::Migration[6.0]
  def change
    change_column :coupon_codes, :coupon_code, :text
  end
end
