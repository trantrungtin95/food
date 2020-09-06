class ChangeTimeTypeToRestaurants < ActiveRecord::Migration[6.0]
  def change
    remove_column :restaurants, :open_time 
    remove_column :restaurants, :close_time 

    add_column :restaurants, :open_time, :datetime
    add_column :restaurants, :close_time, :datetime

    # Postgres: copy old data, --> convert data
    # integer: 7, --> float: 7.0
    # change_column(:restaurants, :open_time, :datetime)
    # change_column(:restaurants, :close_time, :datetime)
  end
end
