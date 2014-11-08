class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :item_id
      t.integer :borrower_id
      t.integer :loaner_id
      t.boolean :approved
      t.datetime :reserved_start
      t.datetime :reserved_end

      t.timestamps
    end
  end
end
