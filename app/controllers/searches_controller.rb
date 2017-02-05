class SearchesController < ApplicationController
    def new
		@search = Search.new
		@category = Item.uniq.pluck(:category)
	end

	def create
		@search = Search.create(search_params)
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
	end
	
	private

	def search_params
		params.require(:search).permit(:keywords, :category, :rarity, :min_value, :max_value, :description_keywords, :min_release_date, :max_release_date, :min_price, :max_price, :freezable, :openable)
	end
end
