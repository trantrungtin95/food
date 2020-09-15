class AddStatusToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :status, :string, :default => 'Unprocessed'
    #Ex:- :default =>''
  end
end
