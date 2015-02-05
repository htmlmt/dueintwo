class SearchController < ApplicationController
  def search
    if current_user
      
    end
    
    @search = Item.search do
      fulltext params[:search]
    end
    @items = @search.results
  end
end
