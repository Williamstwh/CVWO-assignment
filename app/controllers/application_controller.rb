class ApplicationController < ActionController::Base
    helper_method :current_user
    def current_user
        #The current user, if undefined, will be the user with the unique id as specified in the session.
        @current_user ||= User.find_by(id: session[:current_user_id])
    end

    private

    def authenticate_user!
        #if the user is undefined, redirect to the login page, i.e. session/new
        redirect_to new_session_path, notice: 'Please login first' if current_user.blank?
    end

    def authorize_admin!
        #if the user is not an admin, redirect to my/account page
        redirect_to my_account_path, notice: 'You are not allowed to perform this action' unless current_user.admin?
    end
end
