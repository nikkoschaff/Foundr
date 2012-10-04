class RolesController < ApplicationController
    before_filter :filter_authenticated, :only => [ :index,
                                                    :new,
                                                    :show,
                                                    :edit,
                                                    :create,
                                                    :update,
                                                    :destroy,
                                                    :logout,
                                                    :search ]
    before_filter :filter_unauthenticated, :only => [ :login,
                                                      :authenticate,
                                                      :signup,
                                                      :signup_post ]
    before_filter :find_role, :only => [ :show,
                                         :edit,
                                         :update,
                                         :destroy ]

    def index
        @roles = Role.search(params[:search])
    end

    def new
        @role = Role.new
    end

    def create
        @role = Role.new( params[:role] )
        if @role.save!
            redirect_to :action => :index
        else
            render :action => :signup
        end
    end

    def update
        if @role.update_attributes( params[:role] )
            redirect_to :action => :index
        else
            render :action => :edit
        end
    end

    def destroy
        @role.destroy
        redirect_to :action => :index
    end

    def signup
        if params.has_key? :role
            @role = Role.new( params[:role] )
            @role.build_profile(:about => "", :headline => "", :name => "")
            if @role.save
                self.role_current = @role
                redirect_to :action => :index
            end
        else
            @role = Role.new
        end
    end

    def logout
        role_unauthenticate
        redirect_to :action => :login, :method => :login
    end

    def authenticate
        if role_authenticate( params[:email].downcase, params[:password] )
            redirect_to :action => :index
        else
            render :action => :login
        end
    end

    def search
        filters = Hash.new
        filters[:params] = params
        #redirect_to :action => :index, :filters => filters, :method => :index
    end

    def login
        if role_authenticated?
            redirect_to :action => "index", :controller => "roles"
        end
    end


private

    def find_role
        @role = Role.find( params[:id] )
    end

end