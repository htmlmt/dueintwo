class RemoveReservedEndFromLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :reserved_end, :datetime
  end
end
