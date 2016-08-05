class ProductsController < ApplicationController
	include ApplicationHelper
	layout "admin"

	def index
		@active = 'products'
		if params[:keyword]
			@products = Product.all.page(params[:page]).where(["title LIKE :title OR model LIKE :model", {:title => "%" + params[:keyword] + "%", :model => "%" + params[:keyword] + "%"}]).order(:title)
		else
			@products = Product.all.page(params[:page]).order(:title)
		end
	end

	def create
		@active = 'products'
		@categories = Category.all
		if request.request_method() == 'POST'
			# render :text => params.inspect
			# return

			@product = Product.new(product_params)
		    if @product.save
		    	if params[:categories] 
		    		params[:categories].each { |category_id|
		    			@product.product_categories.create(@product.id)
		    		}
		    	end
		     	if params[:files]
					upload_files(params[:files], @product, 'product')
				end
		     	flash[:message_success] = t('general.lbl-add-new-success')
				redirect_to '/products'
			else
				flash[:message_error] = t('general.lbl-add-new-dont-success')
		     end
		else
			@product = Product.new
		end
	end


	def edit
		@active = 'products'
		@product = Product.find(params[:id])
		@images = Attachment.where('id_item = ? AND object = ?', params[:id], 'product').order(sort: :asc)
		if request.request_method == 'PATCH'
			Rails.logger.info("Person attributes hash: #{product_params}")
			if @product.update_attributes(product_params)
				if params[:files]
					upload_files(params[:files], @product, 'product')
				end
				flash[:message_success] = t('general.lbl-update-success')
				redirect_to '/products'
			else
				flash[:message_error] = t('general.lbl-update-dont-success')
			end	
		end
	end

	def list
		
	end

	def delete
		@product = Product.find(params[:id])
		if @product.destroy
			@products = Product.all.page(params[:page]).order(:title)
			template = render_to_string(:action => "list", :layout => false)
			render json: {status: 1, message: t('general.lbl-delete-success'), html: template} 
		else
			render json: {status: 0, message: t('general.lbl-delete-dont-success')} 
		end
	end

	private
		def product_params
			params.require(:product).permit(:title, :image, :description, :model)
		end
end
