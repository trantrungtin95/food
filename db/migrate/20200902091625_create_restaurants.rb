class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :user_id
      t.string :address
      t.string :open_time
      t.string :close_time

      t.timestamps
    end
  end
end
