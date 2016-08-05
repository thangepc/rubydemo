class AdminsController < ApplicationController
	layout "admin"
	def dashboard

	end

	def index
		@active = 'admin'
		@users = Admin.all.page(params[:page]).order(:email)
	end

	def create 
	  	@active = 'admin'
		if request.request_method() == 'POST'

			@admin = Admin.new(user_params)
		     if @admin.save
		     	flash[:message_success] = t('general.lbl-add-new-success')
				redirect_to '/admins'
			else
				flash[:message_error] = t('general.lbl-add-new-dont-success')
		    end
		else
			@admin = Admin.new
		end
	end


	def edit
		@active = 'admin'
		@admin = Admin.find(params[:id])
		# upload_files
		if request.request_method == 'PATCH'
			params[:admin].delete(:password) if params[:admin][:password].blank?
			if @admin.update_attributes(user_params)
				flash[:message_success] = t('general.lbl-update-success')
				redirect_to '/admins'
			else
				flash[:message_error] = t('general.lbl-update-dont-success')
			end	
		end
	end

	def delete
		@admin = Admin.find(params[:id])
		if @admin.destroy
			@admins = Admin.all.page(params[:page]).order(:title)
			template = render_to_string(:action => "list", :layout => false)
			render json: {status: 1, message: t('general.lbl-delete-success'), html: template} 
		else
			render json: {status: 0, message: t('general.lbl-delete-dont-success')} 
		end
	end

	def signup
		@user = Admin.new
		render :layout => false
	end

	def change_status
		responce = {status: 0, message: "Update status isn't successful."}
		if params[:id] && params[:status]
			id = params[:id]
			status = params[:status]
			admin = Admin.find(id)
			admin.status = status
			if admin.save
				responce = {status: 1, message: 'Update status is successful.'}
			end
		end
		render :json => responce
	end



	private
	  def user_params
	    params.require(:admin).permit(:first_name, :last_name, :email, :password, :status)
	  end
end
