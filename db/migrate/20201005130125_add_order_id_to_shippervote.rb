class AddOrderIdToShippervote < ActiveRecord::Migration[6.0]
  def change
    add_column :shippervotes, :order_id, :integer
  end
end
