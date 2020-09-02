class AddUserIdToDish < ActiveRecord::Migration[6.0]
  def change
    add_column :dishes, :user_id, :integer
  end
end
