class CreateUservotes < ActiveRecord::Migration[6.0]
  def change
    create_table :uservotes do |t|
      t.integer :user_id
      t.integer :shipper_id
      t.integer :order_id
      t.float :rating

      t.timestamps
    end
  end
end
