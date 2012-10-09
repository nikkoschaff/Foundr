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
        #@roles = Role.order("email").page(params[:page]).per_page(10)
#        if params[:latitude].nil? or params[:longitude].nil or params[:accuracy].nil?
#            @roles = nil
#        else
            #geoloc = Geolocation.where("role_id=?",session[:role_id]).first
 #           geoloc.accuracy = params[:accuracy]
 #           geoloc.latitude = params[:latitude]
 #           geoloc.longitude = params[:longitude]
 #           geoloc.save!
            @roles = Geolocation.nearest_roles( 20, 15.5, session[:role_id] )
           # @roles = @roles.paginate( :page => params[:page], :per_page => 10)
#       end
    end

    # Returns a list of (TODO determine) role objects as @roles
    # TODO
    def refresh
        @tag_list = nil
        @ambition_ids = nil
        if params.has_key?(:tag_list)
            @tag_list = params[:tag_list]
        end
        if params.has_key?(:ambition_ids)
            @ambition_ids = params[:ambition_ids]
        end
        # TODO (when ready) let jquery handle this part
        @roles = Geolocation.nearest_roles
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
            @role.build_geolocation(:accuracy => 0.0,
             :latitude => 0.0, :longitude => 0.0, :role_id => @role.id )
            if @role.save
                @role.encrypt_password
                @role.save!
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