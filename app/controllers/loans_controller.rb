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
    if @loan.update(approved: true)
      format.html { redirect_to "/loans", notice: 'Loan was successfully updated.' }
      format.json { render :show, status: :ok, location: @loan }
    else
      format.html { render :edit }
      format.json { render json: @loan.errors, status: :unprocessable_entity }
    end
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    
    respond_to do |format|
      if @loan.save
        @loan.update(reserved_end: @loan.reserved_start + 2.days)
        format.html { redirect_to @loan, notice: 'Your request to borrow has been sent. Please wait for the owner to approve or deny your rental.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
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
      params.require(:loan).permit(:item_id, :borrower_id, :loaner_id, :approved, :reserved_start, :reserved_end)
    end
end
