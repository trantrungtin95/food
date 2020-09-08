class ChangeVoteRate < ActiveRecord::Migration[6.0]
  def change
    change_column(:votes, :rate, :float)
  end
end
