class ChangeDataTypeForRating < ActiveRecord::Migration[6.0]
  def change
    change_column :shippervotes, :rating, :float
  end
end
