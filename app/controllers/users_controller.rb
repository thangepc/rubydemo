class UsersController < ApplicationController
	before_action :require_user, only: [:index]
	def signup
		if request.request_method() == 'POST'
			@user = User.new(user_params)
		     if @user.save
		     	flash[:message_success] = t('general.lbl-add-new-success')
				redirect_to signin_path()
			else
				flash[:message_error] = t('general.lbl-add-new-dont-success')
		    end
		else
			@user = User.new
			render :layout => false
		end
		# @user = User.new
	end

	def signin
	  	if request.request_method() == 'POST'
			@user = User.find_by_email(params[:session][:email])
		  	if User.authenticate(params[:session][:email], params[:session][:password])
		    	session[:client] = @user.id
		    	redirect_to index_path()
		  	else
		  		flash[:message_error] = t('login.lbl-message-login-faild')
		    	redirect_to signin_path()
		  	end 
		end
	end

	def logout
		session[:client] = nil
		flash[:message_success] = t('logout.lbl-message-logout-success')
		redirect_to signin_path()
	end


	def index
		@active = 'users'
		if params[:email] != nil
			@users = User.where('email LIKE ?', "%" + params[:email] + "%").page(params[:page]).order(:email)
		else
			@users = User.all.page(params[:page]).order(:email)
		end
		render layout: "admin"
	end

	def change_status
		responce = {status: 0, message: "Update status isn't successful."}
		if params[:id] && params[:status]
			id = params[:id]
			status = params[:status]
			user = User.find(id)
			user.status = status
			if user.save
				responce = {status: 1, message: 'Update status is successful.'}
			end
		end
		render :json => responce
	end


	private
	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password, :status)
	  end
end
