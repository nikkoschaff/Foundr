class RolesController < ApplicationController
    before_filter :filter_authenticated, :only => [ :index,
                                                    :new,
                                                    :show,
                                                    :edit,
                                                    :create,
                                                    :update,
                                                    :destroy,
                                                    :logout ]
    before_filter :filter_unauthenticated, :only => [ :login,
                                                      :authenticate,
                                                      :signup ]
    before_filter :find_role, :only => [ :show,
                                         :edit,
                                         :update,
                                         :destroy ]

    def index
        @roles = Role.all
    end

    def new
        @role = Role.new
    end

    def create
        @role = Role.create( params[:role] )
        if @role.save
            redirect_to :action => :index
        else
            render :action => :new
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
        @role = Role.new
    end

    def logout
        role_unauthenticate
        redirect_to :action => :login
    end

    def authenticate
        if role_authenticate( params[:name], params[:password] )
            redirect_to :action => :index
        else
            render :action => :login
        end
    end

private

    def find_role
        @role = Role.find( params[:id] )
    end

end