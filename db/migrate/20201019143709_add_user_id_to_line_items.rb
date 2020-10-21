class AddUserIdToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :user_id, :integer
  end
end
