class CreateRoomchats < ActiveRecord::Migration[6.0]
  def change
    create_table :roomchats do |t|
      t.integer :order_id
      t.integer :sender_id
      t.text :content

      t.timestamps
    end
  end
end
