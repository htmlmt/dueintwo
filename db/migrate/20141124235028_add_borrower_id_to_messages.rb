class AddBorrowerIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :borrower_id, :integer
  end
end
