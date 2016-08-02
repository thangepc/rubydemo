class CategoriesController < ApplicationController
	layout "admin"
	def index
		@categories = Category.all.page(params[:page]).order(:title)
	end

	def create
		if request.request_method() == 'POST'
			@category = Category.new(category_params)
			# Form isn't correctly filled message
		     if @category.save
		        flash[:notice] = "Dateien wurden hochgeladen und die Daten wurden gespeichert."
				redirect_to '/categories'
		     end
		else
			@category = Category.new
		end
	end

	def edit
		@category = Category.find(params[:id])
		if request.request_method == 'PATCH'
			Rails.logger.info("Person attributes hash: #{category_params}")
			# logger.debug "Person attributes hash: #{category_params}"
			if @category.update_attributes(category_params)
				redirect_to '/categories'
			end	
		end
	end

	def list
		# @categories = Category.all.page(params[:page]).order(:title)
	end

	def delete
		@category = Category.find(params[:id])
		if @category.destroy
			@categories = Category.all.page(params[:page]).order(:title)
			template = render_to_string(:action => "list", :layout => false)
			render json: {status: 1, message: 'Delete success', html: template} 
		else
			render json: {status: 0, message: 'Delete error'} 
		end
	end

	private
		def category_params
			params.require(:category).permit(:title, :image, :description)
		end
end
