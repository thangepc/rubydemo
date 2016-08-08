class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

	def set_locale
	  if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
	    l = cookies[:educator_locale].to_sym
	  else
	    begin
	      country_code = request.location.country_code
	      if country_code
	        country_code = country_code.downcase.to_sym
	        # use russian for CIS countries, english for others
	        [:vi, :kz, :ua, :by, :tj, :uz, :md, :az, :am, :kg, :tm].include?(country_code) ? l = :vi : l = :en
	      else
	        l = I18n.default_locale # use default locale if cannot retrieve this info
	      end
	    rescue
	      l = I18n.default_locale
	    ensure
	      cookies.permanent[:educator_locale] = l
	    end
	  end
	  I18n.locale = l
	end


	helper_method :current_user, :current_client

	def current_user 
	  @current_user ||= Admin.find(session[:user_id]) if session[:user_id] 
	end

	def current_client
		@current_client ||= User.find(session[:client]) if session[:client]
	end

	def require_user 
	  redirect_to '/login' unless current_user 
	end

end
