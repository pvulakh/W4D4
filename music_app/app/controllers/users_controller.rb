class UsersController < ApplicationController

    def index 
        render :show
    end 

    def new 
        #debugger
        @user = User.new
        render :new 
    end 

    def create 
        @user = User.new(user_params)
        if @user.save
            log_in_user!(@user) #THIS IS LOGGING IN AFTER SIGNING UP
            redirect_to user_url(@user) #for now just redirect here
        else  
            redirect_to new_user_url #invalid singup credentials, try again
        end 
    end 

    def user_params
        params.require(:user).permit(:email, :password)
    end
end