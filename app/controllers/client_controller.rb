class ClientController < ApplicationController

	def index
		# images = Attachment.where('id_item = ? AND object = ?', 20, 'product').order(sort: :asc).first
		# render :json => images
		@products = Product.all.page(params[:page]).order(:title)
	end

	def detail
		if params[:id] != nil
			@product = Product.find(params[:id])
		end
	end

	def categories
		if params[:id] != nil
			@category = Category.find(params[:id])
			@productCategory = ProductCategory.where(:category_id => params[:id])
			@products = @productCategory
		end
	end
end
