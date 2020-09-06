class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :dish_id
      t.integer :rate

      t.timestamps
    end
  end
end
