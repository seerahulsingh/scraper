class RestaurantsController < ApplicationController
	def index
		@rest = Restaurant.all
	end
end
