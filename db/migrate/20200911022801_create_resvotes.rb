class CreateResvotes < ActiveRecord::Migration[6.0]
  def change
    create_table :resvotes do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :rating

      t.timestamps
    end
  end
end
