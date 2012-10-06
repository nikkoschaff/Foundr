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
        @tag_list = nil
        @ambition_ids = nil
        if params.has_key?(:tag_list)
            @tag_list = params[:tag_list]
        end
        if params.has_key?(:ambition_ids)
            @ambition_ids = params[:ambition_ids]
        end
        # TODO (when ready) let jquery handle this part
        @roles = nil
        #@roles = Geolocation.search(:search => params[:search],
        #                     :role_id => session[:role_id],
        #                     :limit => 20,
        #                     :max_distance => 100 )
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
            @role.build_geolocation(:accuracy => -1.0, :latitude => 0.0, :longitude => 0.0, :profile_id => 0.0)
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