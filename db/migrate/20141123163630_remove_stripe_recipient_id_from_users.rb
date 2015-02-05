class RemoveStripeRecipientIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_recipient_id, :integer
  end
end
