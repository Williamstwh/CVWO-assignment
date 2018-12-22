class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password, :admin))
        if @user.save
            redirect_to my_account_path
        else
            render :new
        end
    end
end
