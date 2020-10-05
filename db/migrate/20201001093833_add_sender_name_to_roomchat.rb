class AddSenderNameToRoomchat < ActiveRecord::Migration[6.0]
  def change
    add_column :roomchats, :sender_name, :string
  end
end
