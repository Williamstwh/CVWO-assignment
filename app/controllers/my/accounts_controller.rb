class My::AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :prepare_account, only: [:show, :edit, :update, :delete]

    def show
    end

    def edit
    end

    def update
        #if account updates with params in form, then redirect to my/account, else redirect to edit path
        if @account.update(account_params)
            redirect_to my_account_path
        else
            redirect_to edit_my_account_path
        end
    end

    def delete
    end

    private
    def prepare_account
        #calls the current_user function defined in application_controller and stores it in @account
        @account = current_user
    end

    def account_params
        params.require(:account).permit(:name, :email, :password, :admin)
    end
end
