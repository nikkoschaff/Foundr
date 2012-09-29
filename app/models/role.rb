class Role < ActiveRecord::Base

    NAME_MINIMUM_LENGTH = 8
    NAME_MAXIMUM_LENGTH = 32
    NAME_FORMAT = /^[a-zA-Z0-9_]+$/

    PASSWORD_MINIMUM_LENGTH = 8
    PASSWORD_MAXIMUM_LENGTH = 64

    NAME_PRESENCE_MESSAGE = "name is a required field"
    NAME_UNIQUENESS_MESSAGE = "name is already taken"
    NAME_LENGTH_MESSAGE = "name must be between %i and %i characters" %
                                   [ NAME_MINIMUM_LENGTH, NAME_MAXIMUM_LENGTH ]
    NAME_FORMAT_MESSAGE = "name must begin with an alphabetic character, " +
                          "and contain only alphaebetic, numeric and " + 
                          "underscore characters"

    PASSWORD_LENGTH_MESSAGE = "password must be between %i and %i characters" %
                            [ PASSWORD_MINIMUM_LENGTH, PASSWORD_MAXIMUM_LENGTH]

    CONFIRM_PASSWORD_MESSAGE = "passwords do not match"

    attr_accessible :name, :password, :password_confirm, :profile_id

    attr_accessor :password_confirm

    has_one :profile

    validates :name, :presence => { :message => NAME_PRESENCE_MESSAGE }
    validates :name, :uniqueness => { :message => NAME_UNIQUENESS_MESSAGE }
    validates :name, :length => { :minimum => NAME_MINIMUM_LENGTH,
                                  :maximum => NAME_MAXIMUM_LENGTH,
                                  :message => NAME_LENGTH_MESSAGE }
    validates :name, :format => { :with => NAME_FORMAT,
                                  :message => NAME_FORMAT_MESSAGE }

    validates :password, :length => { :minimum => PASSWORD_MINIMUM_LENGTH,
                                      :maximum => PASSWORD_MAXIMUM_LENGTH,
                                      :message => PASSWORD_LENGTH_MESSAGE },
                         :allow_nil => true

    validate :confirm_password, :unless => :password_nil?

    before_save :encrypt_password

    def self.authenticate( name, password )
        role = find_by_name( name )
        if role and role.password == Role.digest( password )
            role
        else
            nil
        end 
    end

private

    def password_nil?
        password.nil?
    end

    def confirm_password
        if password != password_confirm
            errors.add( :password, CONFIRM_PASSWORD_MESSAGE )
        end
    end

    def encrypt_password
        self.password = Role.digest( password )
    end

    def self.digest( source )
        Digest::SHA2.base64digest( source )
    end

end
