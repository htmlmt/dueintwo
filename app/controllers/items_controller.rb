class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  require 'twilio-ruby'

  # GET /items
  # GET /items.json
  def search
    @search = Item.search do
      fulltext params[:search]
    end
    @items = @search.results
  end
  
  def index
    if current_user
      @pending_borrows = Loan.where(borrower_id: current_user.id, approved: nil)
      @borrows_pending = []
      @pending_borrows.each do |loan|
        @borrows_pending << loan.item
      end
      
      @items = Item.all - Item.where(user: current_user) - @borrows_pending
      
      @distances = []
      
      @community_items = []
      
      @items.each do |item|
        a = Geokit::Geocoders::GoogleGeocoder.geocode "#{current_user.address} #{current_user.city} #{current_user.state} #{current_user.zip}"
        b = Geokit::Geocoders::GoogleGeocoder.geocode "#{item.user.address} #{item.user.city} #{item.user.state} #{item.user.zip}"
        if a.distance_to(b) < 10
          @community_items << item.id
        end
      end
      
      @search = Item.search do
        fulltext params[:search]
        
        without(:user_id, current_user.id)
        with(:id, @community_items)
      end
      @items = @search.results
    else
      if request.ip == "127.0.0.1"
        @location_ll = "43.5540953,-96.7280335"
      else
        @location = request.location
        @location_ll = @location.latitude + @location.longitude
      end
      
      @borrowed = Loan.where(approved: true)
  
      @items_borrowed = []
  
      @borrowed.each do |loan|
        @item = Item.find(loan.item_id)
        @items_borrowed << @item
      end
      
      @items = Item.all - @items_borrowed
      
      @distances = []
      
      @community_items = []
      
      @items.each do |item|
        a = Geokit::Geocoders::GoogleGeocoder.geocode "#{@location_ll}"
        b = Geokit::Geocoders::GoogleGeocoder.geocode "#{item.user.address} #{item.user.city} #{item.user.state} #{item.user.zip}"
        if a.distance_to(b) < 10
          @community_items << item.id
        end
      end
      
      @search = Item.search do
        fulltext params[:search]
        
        with(:id, @community_items)
      end
      @items = @search.results
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @loan = Loan.new
    @message = Message.new
    
    query = @item.name
    
    @search = Item.search do
      fulltext query
    end
    
    @items = @search.results
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save_with_recipient
        User.find(current_user.id).items << @item
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :photo, :price, :user_id, :stripe_card_token)
    end
end
