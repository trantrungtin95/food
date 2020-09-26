class AddNameToShippers < ActiveRecord::Migration[6.0]
  def change
    add_column :shippers, :name, :string
  end
end
