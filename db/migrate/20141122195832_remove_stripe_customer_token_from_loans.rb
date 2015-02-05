class RemoveStripeCustomerTokenFromLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :stripe_customer_token, :integer
  end
end
