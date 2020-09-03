class SampleNameChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column(:restaurants, :open_time, :datetime)
  end
end
