require 'test_helper'

class RolesControllerTest < ActionController::TestCase
    test "should 401 index" do
        session[:role_id] = nil

        get :index

        assert_response :unauthorized
    end

    test "should 403 index" do
        # TODO
    end

    test "should 401 new" do
        session[:role_id] = nil

        get :new

        assert_response :unauthorized
    end

    test "should 403 new" do
        # TODO
    end

    test "should 401 show" do
        session[:role_id] = nil

        get :show, :id => 1

        assert_response :unauthorized
    end

    test "should 403 show" do
        # TODO
    end

    test "should 401 edit" do
        session[:role_id] = nil

        get :edit, :id => 1

        assert_response :unauthorized
    end

    test "should 403 edit" do
        # TODO
    end

    test "should 401 create" do
        session[:role_id] = nil

        post :create, :role => { :name => "test_user_401",
                                 :password => "unauthorized",
                                 :password_confirm => "unauthorized" }

        assert_response :unauthorized
    end

    test "should 403 create" do
        # TODO
    end

    test "should 401 update" do
        session[:role_id] = nil

        post :update, :id => 1,
                      :role => { :name => "test_user_401",
                                 :password => "unauthorized",
                                 :password_confirm => "unauthorized" }

        assert_response :unauthorized
    end

    test "should 403 update" do
        # TODO
    end

    test "should 401 destroy" do
        session[:role_id] = nil

        post :destroy, :id => 1

        assert_response :unauthorized
    end

    test "should 403 destroy" do
        # TODO
    end

    test "should 401 logout" do
        session[:role_id] = nil

        post :logout

        assert_response :unauthorized
    end

    test "should 403 login" do
        session[:role_id] = 1

        get :login

        assert_response :forbidden
    end

    test "should 403 authenticate" do
        session[:role_id] = 1

        post :authenticate, :name => "test_user_1",
                            :password => "password_1"

        assert_response :forbidden
    end

    test "should 403 signup" do
        session[:role_id] = 1

        get :signup

        assert_response :forbidden
    end

    test "should get index" do
        session[:role_id] = 1

        get :index

        assert_response :success
    end

    test "should get new" do
        session[:role_id] = 1

        get :new

        assert_response :success
    end

    test "should create role" do
        session[:role_id] = 1

        r = Role.all.size
        hash = { :name => "test_user_create",
                 :password => "password_create",
                 :password_confirm => "password_create" }

        post :create, :role => hash

        assert_redirected_to :action => :index
        assert_equal( r + 1, Role.all.size )
        assert_role( Role.last, hash )
    end

    test "should not create role" do
        session[:role_id] = 1

        r = Role.all.size
        hash = { :name => "test_user_create",
                 :password => "password_create",
                 :password_confirm => "dont_create" }

        post :create, :role => hash

        assert_response :success
        assert_equal( r, Role.all.size )
    end

    test "should get show" do
        session[:role_id] = 1

        get :show, :id => 1

        assert_response :success
    end

    test "should get edit" do
        session[:role_id] = 1

        get :edit, :id => 1

        assert_response :success
    end

    test "should update role" do
        session[:role_id] = 1

        r = Role.all.size
        hash = { :name => "test_user_update",
                 :password => "password_update",
                 :password_confirm => "password_update" }

        post :update, :id => 2,
                      :role => hash

        assert_redirected_to :action => :index
        assert_equal( r, Role.all.size )
        assert_role( Role.find( 2 ), hash )
    end

    test "should not update role" do
        session[:role_id] = 1

        r = Role.all.size
        hash = { :name => "test_user_update",
                 :password => "password_update",
                 :password_confirm => "dont_update" }

        post :update, :id => 2,
                      :role => hash

        hash = { :name => "test_user_2",
                 :password => "password_2" }
        assert_response :success
        assert_equal( r, Role.all.size )
        assert_role( Role.find( 2 ), hash )
    end

    test "should destroy role" do
        session[:role_id] = 1

        r = Role.all.size

        post :destroy, :id => 2

        assert_redirected_to :action => :index
        assert_equal( r - 1, Role.all.size )
        assert_raise( ActiveRecord::RecordNotFound ) { Role.find( 2 ) }
    end

    test "should get login" do
        session[:role_id] = nil

        get :login

        assert_response :success
    end

    test "should get signup" do
        session[:role_id] = nil

        get :signup

        assert_response :success
    end

    test "should authenticate role" do
        session[:role_id] = nil

        post :authenticate, :name => "test_user_1",
                            :password => "password_1"

        assert_redirected_to :action => :index
        assert_equal( 1, session[:role_id] )
    end

    test "should not authenticate role" do
        session[:role_id] = nil

        post :authenticate, :name => "test_user_1",
                            :password => "password_2"

        assert_response :success
        assert_equal( nil, session[:role_id] )
    end

    test "should logout role" do
        session[:role_id] = 1

        post :logout

        assert_redirected_to :action => :login
        assert_equal( nil, session[:role_id] )
    end

private

    def assert_role( role, hash )
        assert_equal( hash[:name], role.name )
        assert_equal( digest( hash[:password] ), role.password )
    end

    def digest( source )
        Digest::SHA2.base64digest( source )
    end

end
