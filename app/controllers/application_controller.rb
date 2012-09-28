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

    def role_authenticate( name, password )
        raise RuntimeError if role_authenticated?

        @role_current = Role.authenticate( name, password )
        session[:role_id] = @role_current.id if @role_current
        return @role_current
    end

    def role_unauthenticate
        raise RuntimeError if !role_authenticated?

        session.delete :role_id
        @role_current = nil
        return true
    end

    def filter_authenticated
        filter_unauthorized unless role_authenticated?
    end

    def filter_unauthenticated
        filter_unauthorized unless !role_authenticated?
    end

    def filter_unauthorized
        #redirect_to :action => :unauthorized, :controller => :application
        return true #false
    end

end
