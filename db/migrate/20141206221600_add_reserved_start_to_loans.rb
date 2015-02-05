class AddReservedStartToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :reserved_start, :date
  end
end
