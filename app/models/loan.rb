class Loan < ActiveRecord::Base
  belongs_to :item
  belongs_to :loaner, :class_name => "User"
  belongs_to :borrower, :class_name => "User"
  belongs_to :charges
  has_many :messages
  
  attr_accessor :stripe_card_token

  def save_with_payment

    if valid?
      
      if self.borrower.stripe_customer_token.present? && self.borrower.stripe_customer_token != 0
        
        self.stripe_customer_token = self.borrower.stripe_customer_token
        
        if self.borrower.stripe_recipient_id.present? == false || self.borrower.stripe_recipient_id == 0
          
          recipient = Stripe::Recipient.create(
            :name => self.borrower.first_name + " " + self.borrower.last_name,
            :type => "individual",
            :email => self.borrower.email,
            :card => stripe_card_token
          )
          self.borrower.update_attribute(:stripe_recipient_id, recipient.id)
        end
        
      else
        
        customer = Stripe::Customer.create(
          card: stripe_card_token, 
          email: email
        )
        
        self.stripe_customer_token = customer.id
        self.borrower.update_attribute(:stripe_customer_token, customer.id)
        
      end
      save!
    end
    
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end
end
