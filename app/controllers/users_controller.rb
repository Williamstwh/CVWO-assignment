class UsersController < ApplicationController

    def new
        #if there is an existing session, redirect to my/account path, disallowing user from creating new account
        redirect_to my_account_path unless session[:current_user_id] == nil
        #create a new user
        @user = User.new
    end

    def create
        #create a new user with parameters specfied in form
        @user = User.new(user_params)
        #if user saves, log the user in automatically by changing the session id to the new user's id.
        if @user.save
            session[:current_user_id] = @user.id
            redirect_to my_account_path
        #else prompt user to create a new account again
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :admin)
    end
end
