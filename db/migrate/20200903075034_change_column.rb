class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column(:line_items, :product_id, :integer)
  end
end
