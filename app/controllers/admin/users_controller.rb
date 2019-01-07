class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :find_user, only: [:show, :edit, :update, :destroy]

    def index
        #Get all the users
        @users = User.all
    end

    def show
    end

    def new
        #Create new user
        @user = User.new
    end

    def create
        #Create new user using params submitted in form
        @user = User.new(user_params)
        #if user saves, redirect to index, else render new uer path again
        if @user.save
            redirect_to admin_users_path
        else
            render new_admin_user_path
        end
    end

    def edit
    end

    def update
        #if user updates with params in the form, redirect to the user's path, else render edit path again
        if @user.update(user_params)
            redirect_to admin_user_path(@user)
        else
            redirect_to edit_admin_user_path(@user)
        end
    end

    def destroy
        #destroy the user and redirect to index
        @user.destroy
        redirect_to admin_users_path
    end

    private
    def find_user
        #query databse for user with the given id
        @user = User.find(params[:id])
    end

    def user_params
        #strong params that takes in name, email, password and admin
        parameters = params.require(:user).permit(:name, :email, :password, :admin)
    end
end
