module RolesHelper
    def role_login_path
        url_for :controller => :roles,
                :action => :login
    end

    def role_logout_path
        url_for :controller => :roles,
                :action => :logout
    end

    def role_authenticate_path
        url_for :controller => :roles,
                :action => :authenticate
    end

    def role_signup_path
        url_for :controller => :roles,
                :action => :signup
    end
end
