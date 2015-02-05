class AddStripeCardTokenToItems < ActiveRecord::Migration
  def change
    add_column :items, :stripe_card_token, :string
  end
end
