class AddReservedEndToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :reserved_end, :date
  end
end
