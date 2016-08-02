class SessionsController < ApplicationController

	def login
		if request.request_method() == 'POST'
			@user = Admin.find_by_email(params[:session][:email])
		  	if @user && @user.authenticate(params[:session][:password])
		    	session[:user_id] = @user.id
		    	redirect_to controller: 'admins', action: 'dashboard'
		  	else
		    	redirect_to '/login'
		  	end 
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to '/login'
	end

end
