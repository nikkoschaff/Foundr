class ApplicationController < ActionController::Base
    protect_from_forgery

private

    def role_authenticated?
        ( session.has_key?( :role_id ) and !session[:role_id].nil? )
    end

    def role_current
        unless !role_authenticated
            @role_current ||= Role.find( session[:role_id] )
        end
        return @role_current
    end

    def role_current=( role )
        unless role.nil?
            session[:role_id] = role.id
        else
            session.delete :role_id
        end
        @role_current = role
    end

    def role_authenticate( name, password )
        raise RuntimeError if role_authenticated?

        self.role_current = Role.authenticate( name, password )
    end

    def role_unauthenticate
        raise RuntimeError if !role_authenticated?

        self.role_current = nil
    end

    def filter_authenticated
        unless role_authenticated?
            filter_unauthorized
        else
            true
        end
    end

    def filter_unauthenticated
        if role_authenticated?
            filter_forbiden
        else
            true
        end
    end

    def filter_unauthorized
        render 'application/unauthorized', :status => :unauthorized
        return false
    end

    def filter_forbiden
        render 'application/forbiden', :status => :forbidden
        return false
    end

end
