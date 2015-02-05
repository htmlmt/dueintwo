class RemoveReservedStartFromLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :reserved_start, :datetime
  end
end
