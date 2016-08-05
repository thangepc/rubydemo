class CategoriesController < ApplicationController
	include ApplicationHelper
	before_action :require_user, only: [:index, :create, :edit]
	layout "admin"
	def index
		@active = 'categories'
		@categories = Category.all.page(params[:page]).order(:title)
	end

	def create
		@active = 'categories'
		if request.request_method() == 'POST'

			@category = Category.new(category_params)
		     if @category.save
				if params[:files]
					upload_files(params[:files], @category, 'category')
				end
		     	flash[:message_success] = t('general.lbl-add-new-success')
				redirect_to '/categories'
			else
				flash[:message_error] = t('general.lbl-add-new-dont-success')
		    end
		else
			@category = Category.new
		end
	end

	def edit
		@active = 'categories'
		@category = Category.find(params[:id])
		@images = Attachment.where('id_item = ? AND object = ?', params[:id], 'category').order(sort: :asc)
		# upload_files
		if request.request_method == 'PATCH'
			# raise category_params.inspect
			Rails.logger.info("Person attributes hash: #{category_params}")
			if @category.update_attributes(category_params)
				if params[:files]
					upload_files(params[:files], @category, 'category')
				end
				flash[:message_success] = t('general.lbl-update-success')
				redirect_to '/categories'
			else
				flash[:message_error] = t('general.lbl-update-dont-success')
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
			render json: {status: 1, message: t('general.lbl-delete-success'), html: template} 
		else
			render json: {status: 0, message: t('general.lbl-delete-dont-success')} 
		end
	end

	private
		def category_params
			params.require(:category).permit(:title, :image, :description, :parent_id)
		end
end
