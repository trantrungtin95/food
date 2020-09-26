class AddLongitudeToShippers < ActiveRecord::Migration[6.0]
  def change
    add_column :shippers, :longitude, :float, :default => 0
  end
end
