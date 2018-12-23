class My::AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :prepare_account, only: [:show, :update, :edit, :delete]

    def show
    end

    def edit
    end

    def update
        if @account.update
            @current_user = @account
            redirect_to my_account_path
        else
            render edit_my_account_path
        end
    end

    def delete
    end

    private
    def prepare_account
        @account = current_user
    end

    def account_params
        params.require(:user).permit(:name, :email, :password, :admin)
    end
end
