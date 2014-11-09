class HomeController < ApplicationController
  def index
    if current_user
      @in_my_house = Loan.where(borrower_id: current_user.id, approved: true)
      @in_their_house = Loan.where(loaner_id: current_user.id, approved: true)
      @pending = Loan.where(loaner_id: current_user.id, approved: nil)
  
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
  
      @on_my_porch = Item.where(user_id: current_user.id) - @items_pending - @items_in_their_house
  
      @community_items = Item.all - @on_my_porch - @items_in_my_house - @items_in_their_house
  
      @distances = []
      @community_items.each do |item|
        a = Geokit::Geocoders::GoogleGeocoder.geocode "#{current_user.address} #{current_user.city} #{current_user.state} #{current_user.zip}"
        b = Geokit::Geocoders::GoogleGeocoder.geocode "#{item.user.address} #{item.user.city} #{item.user.state} #{item.user.zip}"
        if a.distance_to(b) > 10
          @community_items.delete(item)
        end
      end
    end
  end
end
