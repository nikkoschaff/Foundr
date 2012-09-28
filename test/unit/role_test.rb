require 'test_helper'

class RoleTest < ActiveSupport::TestCase

    test "name" do
        assert_equal( "test_user_1", Role.find( 1 ).name )
        assert_equal( "test_user_2", Role.find( 2 ).name )

        r = Role.new( :password => "test_password" )
        assert( !r.valid? )
        assert_equal( [ Role::NAME_PRESENCE_MESSAGE,
                        Role::NAME_LENGTH_MESSAGE,
                        Role::NAME_FORMAT_MESSAGE ], r.errors[:name] )

        r = Role.new( :name => "aaa",
                      :password => "test_password",
                      :password_confirm => "test_password" )
        assert( !r.valid? )
        assert_equal( [ Role::NAME_LENGTH_MESSAGE ], r.errors[:name] )

        r = Role.new( :name => "inval?d_format",
                      :password => "test_password",
                      :password_confirm => "test_password" )
        assert( !r.valid? )
        assert_equal( [ Role::NAME_FORMAT_MESSAGE ], r.errors[:name] )

        r = Role.new( :name => "test_user_1",
                      :password => "test_password",
                      :password_confirm => "test_password" )
        assert( !r.valid? )
        assert_equal( [ Role::NAME_UNIQUENESS_MESSAGE], r.errors[:name] )

        r = Role.new( :name => "test_user_3",
                      :password => "test_password",
                      :password_confirm => "test_password" )
        assert( r.valid? )
    end

    test "password" do
        assert_equal( "OMWuK80fEqomnkWujIdi8DBjClE33W0ceZwBlibzMJY=",
                      Role.find( 1 ).password )
        assert_equal( "6nax4lGgyHaz2W0sgfEnNt877TbsspP3nEk8CJkky9w=",
                      Role.find( 2 ).password )

        r = Role.new( :name => "test_user_3",
                      :password => "short",
                      :password_confirm => "short" )
        assert( !r.valid? )
        assert_equal( [ Role::PASSWORD_LENGTH_MESSAGE ], r.errors[:password] )

        r = Role.new( :name => "test_user_3",
                      :password => "long_enough",
                      :password_confirm => "but_different" )
        assert( !r.valid? )
        assert_equal( [ Role::CONFIRM_PASSWORD_MESSAGE ], r.errors[:password] )

        r = Role.new( :name => "test_user_3" )
        assert( r.valid? )

        r = Role.new( :name => "test_user_3",
                      :password => "long_enough",
                      :password_confirm => "long_enough" )
        assert( r.valid? )
    end

    test "encrypt_password" do
        r = Role.new( :name => "test_user_4",
                      :password => "long_enough",
                      :password_confirm => "but_different" )

        r.instance_eval { encrypt_password }

        assert_equal( Digest::SHA2.base64digest( "long_enough" ), r.password )
        assert_equal( "but_different", r.password_confirm )

        r = Role.new( :name => "test_user_4",
                      :password => "long_enough",
                      :password_confirm => "long_enough" )

        r.save
        assert_equal( Digest::SHA2.base64digest( "long_enough" ), r.password )
    end

    test "authenticate" do
        r = Role.authenticate( "test_user_1", "password_1" )
        assert_equal( Role.find( 1 ), r )

        r = Role.authenticate( "test_user_2", "password_2" )
        assert_equal( Role.find( 2 ), r )

        assert( !Role.authenticate( "test_user_1", "wrong_pass" ) )
        assert( !Role.authenticate( "wrong_name", "password_2" ) )
        assert( !Role.authenticate( "wrong_name", "wrong_pass" ) )
    end

end
