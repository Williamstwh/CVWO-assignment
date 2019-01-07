class SessionsController < ApplicationController
    def new
        #redirect to my/account if a current user already exists in the session and tries to access the login page
        redirect_to my_account_path unless session[:current_user_id] == nil
    end

    def create
        #if the email and password entered matches any user, store it in the user
        user = User.find_by(session_params)
        if user.present?
            #save the user's id into the session's id
            session[:current_user_id] = user.id
            #redirect to my/account path upon session being created
            redirect_to my_account_path
        else
            #inform user that incorrect user or password has been entered and render new
            flash[:notice] = "Incorrect user or password"
            render :new
        end
    end

    def destroy
        #set the session id to nil, thus causing user authentication to be invalid
        session[:current_user_id] = nil
        #Redirects to login page
        redirect_to new_session_path, notice: "You have been logged out"
    end

    private
    def session_params
        params.permit(:email, :password)
    end
end
