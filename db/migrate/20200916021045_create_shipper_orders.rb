class CreateShipperOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :shipper_orders do |t|
      t.integer :shipper_id
      t.integer :order_id
      t.string :status, :default => 'Processing'
      #Ex:- :default =>''

      t.timestamps
    end
  end
end
