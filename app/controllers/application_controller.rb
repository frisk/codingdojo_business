class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

	def authorize
	  if current_user.nil?
	    redirect_to login_url, alert: "Not authorized" 
	  else
	    warlock
	  end
	end

	def warlock
	  pos = Staff.find_by_user_id(current_user.id).position.name
	  @warlock ||= pos if pos == "Warlock"
	end
	helper_method :warlock
end
