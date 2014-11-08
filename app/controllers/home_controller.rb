class HomeController < ApplicationController
  def index
    @borrowed_items = Loan.where(borrower_id: current_user.id, approved: true)
    @loaned_items = Loan.where(loaner_id: current_user.id, approved: true)
    @community_items = Item.all
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
