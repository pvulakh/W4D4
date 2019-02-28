class SessionsController < ApplicationController
    before_action :ensure_logged_in, only: [ :destroy ]

    def new
        render :new #new session is the log-in
    end 

    def create 
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        
        if user 
            log_in_user!(user) #THIS IS LOGGINING IN WHEN SOMEONE PRESSES THE NEW_SESSION_URL (log in on main page for pre-existing user who is currently logged out)
            redirect_to user_url(user)
        else  
            redirect_to new_user_url #invalid login credentials, try again
        end
    end 

    def destroy
        logout!(current_user) #rails assumes need to render template w same name as action when no redirect or render explicitly stated
        redirect_to new_session_url
    end 
end 



#sessions and user controllers do not communicate with each other