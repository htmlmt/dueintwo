class RemoveStripeCustomerTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_customer_token, :integer
  end
end
