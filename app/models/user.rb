class User < ActiveRecord::Base
  has_many :items
  has_many :loans
  has_many :messages
  
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  attr_accessor :stripe_card_token
  
  authenticates_with_sorcery!
  
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  
  def stripe_recipient
    return nil if stripe_recipient_id.nil?
    Stripe::Recipient.retrieve stripe_recipient_id
  end
end
