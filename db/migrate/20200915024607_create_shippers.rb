class CreateShippers < ActiveRecord::Migration[6.0]
  def change
    create_table :shippers do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
