class CreateShippervotes < ActiveRecord::Migration[6.0]
  def change
    create_table :shippervotes do |t|
      t.integer :user_id
      t.integer :shipper_id
      t.integer :rating

      t.timestamps
    end
  end
end
