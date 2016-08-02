class AdminsController < ApplicationController
	layout "admin"
	def dashboard

	end

	def signup
		@user = Admin.new
		render :layout => false
	end

	def create 
	  @user = Admin.new(user_params) 
	  if @user.save 
	    session[:user_id] = @user.id 
	    redirect_to '/dashboard' 
	  else 
	    redirect_to '/signup' 
	  end 
	end


	private
	  def user_params
	    params.require(:admin).permit(:first_name, :last_name, :email, :password)
	  end
end
