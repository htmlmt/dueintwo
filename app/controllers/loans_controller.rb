class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :approve, :update, :destroy]

  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.where(loaner_id: current_user.id)
    @rentals = Loan.where(borrower_id: current_user.id)
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end
  
  def approve
    customer_id = @loan.borrower.stripe_customer_token

    Stripe::Charge.create(
      :amount => @loan.item.price.to_i * 100,
      :currency => "usd",
      :customer => customer_id,
      :description => "Due in Two: <%= @loan.item.name %> borrow from <%= @loan.loaner.username %>"
    )
    
    @owner_profit = (((@loan.item.price.to_i * 100) - 30) * 0.975).round

    Stripe::Transfer.create(
       :amount => @owner_profit,
       :currency => "usd",
       :recipient => @loan.loaner.stripe_recipient_id,
       :description => "Due in Two: #{@loan.item.name} loan to #{@loan.borrower.username}"
    )
    
    respond_to do |format|  ## Add this
      if @loan.update(approved: true)
        format.html { redirect_to "/", notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { redirect_to "/", notice: '#{@loan.errors}' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    
    respond_to do |format|
      if @loan.save_with_payment
        @loan.update(reserved_start: Date.parse(Date.strptime(loan_params[:reserved_start],'%m/%d/%Y').strftime("%Y-%m-%d")) )
        @loan.update(reserved_end: @loan.reserved_start + 2.days)
        format.html { redirect_to @loan.item }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new, notice: '#{@loan.errors}' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end 
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params) && @loan.update(reserved_end: @loan.reserved_start + 2.days)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:item_id, :borrower_id, :loaner_id, :approved, :reserved_start, :reserved_end, :stripe_customer_token, :stripe_card_token, :email)
    end
end
