class ApplicationController < ActionController::Base
    helper_method :current_user
    def current_user
        @current_user ||= User.find_by(id: session[:current_user_id])
    end

    private

    def authenticate_user!
        redirect_to new_session_path, notice: 'Please login first' if current_user.blank?
    end

    def authorize_admin!
        redirect_to my_account_path, notice: 'You are not allowed to perform this action' unless current_user.admin?
    end
end
