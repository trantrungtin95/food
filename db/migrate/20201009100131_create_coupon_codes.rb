class CreateCouponCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :coupon_codes do |t|
      t.integer :restaurant_id
      t.integer :coupon_code

      t.timestamps
    end
  end
end
