class AddStatusToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :status, :string, :default => 'not_over'
  end
end
