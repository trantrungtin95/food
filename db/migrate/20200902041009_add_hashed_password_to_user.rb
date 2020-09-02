class AddHashedPasswordToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hashed_password, :string
  end
end
