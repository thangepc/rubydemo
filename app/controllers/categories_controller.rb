class CategoriesController < ApplicationController
	layout "admin"
	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			# redirect_to '/categories'
		end
	end

	private
		def category_params
			params.require(:category).permit(:title, :image)
		end
end
