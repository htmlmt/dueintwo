class HomeController < ApplicationController
  def last
  end
  
  def index    
    if current_user
      
      @in_my_house = Loan.where(borrower_id: current_user.id, approved: true)
      @in_their_house = Loan.where(loaner_id: current_user.id, approved: true)
      @pending = Loan.where(loaner_id: current_user.id, approved: nil)
      @pending_borrows = Loan.where(borrower_id: current_user.id, approved: nil)
  
      @items_in_my_house = []
  
      @in_my_house.each do |loan|
        @item = Item.find(loan.item_id)
        @items_in_my_house << @item
      end
      
      @items_in_their_house = []
  
      @in_their_house.each do |loan|
        @item = Item.find(loan.item_id)
        @items_in_their_house << @item
      end
      
      @items_pending = []
  
      @pending.each do |loan|
        @item = Item.find(loan.item_id)
        @items_pending << @item
      end
      
      @borrows_pending = []
  
      @pending_borrows.each do |loan|
        @item = Item.find(loan.item_id)
        @borrows_pending << @item
      end
  
      @on_my_porch = Item.where(user_id: current_user.id) - @items_pending - @items_in_their_house
  
      @items = Item.all - @on_my_porch - @items_pending - @items_in_my_house - @items_in_their_house - @borrows_pending
      
      @distances = []
      
      @community_items = []
      
      @items.each do |item|
        a = Geokit::Geocoders::GoogleGeocoder.geocode "#{current_user.address} #{current_user.city} #{current_user.state} #{current_user.zip}"
        b = Geokit::Geocoders::GoogleGeocoder.geocode "#{item.user.address} #{item.user.city} #{item.user.state} #{item.user.zip}"
        if a.distance_to(b) < 10
          @community_items << item
        end
      end
      
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
          @community_items << item
        end
      end
    end
  end
end