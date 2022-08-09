class ApplicationController < ActionController::Base
    private
    def require_signin
        if !session[:user_id]
            session[:intended_url] = request.url
            redirect_to new_session_path, alert: "Please sign in first!"
        end
    end
    
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end

    def require_admin
        unless current_user_admin?
            redirect_to root_url, alert: "Unauthorized access!"
        end
    end

    def current_user_admin?
        current_user && current_user.admin?
    end
end
