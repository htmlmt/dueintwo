class Item < ActiveRecord::Base
  has_many :loans
  has_many :photos
  belongs_to :user
  mount_uploader :photo, ItemUploader
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  searchable do
    text :name, :description
    integer :id
    integer :user_id
  end
  
  attr_accessor :stripe_card_token
  
  def save_with_recipient
      user = User.find(self.user_id)
      
      if user.stripe_recipient_id.present? == false || user.stripe_recipient_id == 0

        recipient = Stripe::Recipient.create(
        
          :name => user.first_name + " " + user.last_name,
          :type => "individual",
          :email => user.email,
          :card => stripe_card_token
        )
  
        self.user.update_attribute(:stripe_recipient_id, recipient.id)
      end
    
      rescue Stripe::InvalidRequestError => e
        logger.error "Stripe error while creating customer: #{e.message}"
        errors.add :base, "There was a problem with your credit card."
        false
  end
end
