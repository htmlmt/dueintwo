class ChargesController < ApplicationController
  def new
  end

  def create
    @loan = Loan.new(loan_params)
    
    binding.pry
    
    # Amount in cents
    @amount = params[:amount]
    
    # get the credit card details submitted by the form or app
    token = params[:stripeToken]

    # create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => "",
      :email => "#{current_user.email} %>"
    )

    # charge the Customer instead of the card
    Stripe::Charge.create(
        :amount => @amount, # in cents
        :currency => "usd",
        :customer => customer.id,
        :capture => false
    )
    
    save_stripe_customer_id(current_user, customer.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
