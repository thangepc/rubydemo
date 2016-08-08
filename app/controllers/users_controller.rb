class UsersController < ApplicationController
	def signup
		if request.request_method() == 'POST'
			@user = User.new(user_params)
		     if @user.save
		     	flash[:message_success] = t('general.lbl-add-new-success')
				redirect_to '/dang-nhap'
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
		  	if @user && @user.authenticate(params[:session][:password])
		    	session[:client] = @user.id
		    	redirect_to '/'
		  	else
		  		flash[:message_error] = t('login.lbl-message-login-faild')
		    	redirect_to '/dang-nhap'
		  	end 
		end
	end

	def logout
		session[:client] = nil
		flash[:message_success] = t('logout.lbl-message-logout-success')
		redirect_to '/dang-nhap'
	end


	private
	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password, :status)
	  end
end
