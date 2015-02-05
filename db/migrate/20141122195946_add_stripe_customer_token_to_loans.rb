class AddStripeCustomerTokenToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :stripe_customer_token, :string
  end
end
