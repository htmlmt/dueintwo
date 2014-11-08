class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @items = []
    else
      @items = Item.search params[:q]
    end
  end
end
