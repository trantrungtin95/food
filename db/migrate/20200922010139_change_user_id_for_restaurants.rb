class ChangeUserIdForRestaurants < ActiveRecord::Migration[6.0]
  def change
    remove_column :restaurants, :user_id
    add_column :restaurants, :user_id, :integer
  end
end
