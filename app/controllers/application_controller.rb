class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end


    def logged_in?
        !!current_user
    end

    def require_user
        if !(logged_in?)
            redirect_to root_path
        end
    end
end
