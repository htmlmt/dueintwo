class SearchController < ApplicationController
  def search
    @items = Item.search do
      fulltext params[:q]
    end
  end
end
