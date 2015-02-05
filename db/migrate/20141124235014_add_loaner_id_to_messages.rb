class AddLoanerIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :loaner_id, :integer
  end
end
