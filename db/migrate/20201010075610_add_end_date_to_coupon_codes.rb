class AddEndDateToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :end_date, :datetime
  end
end
