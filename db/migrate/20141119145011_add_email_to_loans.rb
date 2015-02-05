class AddEmailToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :email, :string
  end
end
