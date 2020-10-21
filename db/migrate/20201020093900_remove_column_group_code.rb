class RemoveColumnGroupCode < ActiveRecord::Migration[6.0]
  def change
    remove_column :carts, :group_code
  end
end
