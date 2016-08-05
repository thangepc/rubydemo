class ClientController < ApplicationController

	def index
		@products = Product.all.page(params[:page]).order(:title)
	end
end
