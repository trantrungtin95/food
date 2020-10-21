class AddGroupCodeToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :group_code, :string
  end
end
