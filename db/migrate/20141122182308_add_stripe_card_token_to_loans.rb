class AddStripeCardTokenToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :stripe_card_token, :integer
  end
end
