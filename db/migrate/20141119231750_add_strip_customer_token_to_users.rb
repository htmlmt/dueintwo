class AddStripCustomerTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_token, :integer
  end
end
