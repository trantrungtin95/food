class ChangeColumnDefaultStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :coupon_codes, :status, :string, :default => 'not_over'
  end
end
