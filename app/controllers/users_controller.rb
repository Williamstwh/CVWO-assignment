class UsersController < ApplicationController
    def new
        redirect_to my_account_path unless session[:current_user_id] == nil
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password, :admin))
        if @user.save
            session[:current_user_id] = @user.id
            redirect_to my_account_path
        else
            render :new
        end
    end
end
