class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in? #the ones views will need

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token]) #optimized to not query db again if current_user exists
        #user = User.find_by(session_token: session[:session_token])
    end 

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end 

    def logged_in?
        !!current_user
    end 

    def log_in_user!(user)
        session[:session_token] = user.reset_session_token! #reset so it's a new one, NOT the one from when they were not logged in
    end 

    def logout!(user)
        user.reset_session_token!
        session[:session_token] = nil
    end 
end
