class Role < ActiveRecord::Base
    mount_uploader :picture, PictureUploader
    attr_accessible :picture

    EMAIL_MINIMUM_LENGTH = 8
    EMAIL_MAXIMUM_LENGTH = 32

    EMAIL_FORMAT = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

    PASSWORD_MINIMUM_LENGTH = 8
    PASSWORD_MAXIMUM_LENGTH = 64

    EMAIL_PRESENCE_MESSAGE = "email is a required field"
    EMAIL_UNIQUENESS_MESSAGE = "email is already taken"
    EMAIL_LENGTH_MESSAGE = "email must be between %i and %i characters" %
                                   [ EMAIL_MINIMUM_LENGTH, EMAIL_MAXIMUM_LENGTH ]
    
    EMAIL_FORMAT_MESSAGE = "email must follow the given format: name@host.domain"

    PASSWORD_LENGTH_MESSAGE = "password must be between %i and %i characters" %
                            [ PASSWORD_MINIMUM_LENGTH, PASSWORD_MAXIMUM_LENGTH]

    CONFIRM_PASSWORD_MESSAGE = "passwords do not match"

    attr_accessible :email, :password, :password_confirm, :profile_id, :profile_attributes

    attr_accessor :password_confirm

    has_one :profile
    accepts_nested_attributes_for :profile

    validates :email, :presence => { :message => EMAIL_PRESENCE_MESSAGE }
    validates :email, :uniqueness => { :message => EMAIL_UNIQUENESS_MESSAGE }
    validates :email, :length => { :minimum => EMAIL_MINIMUM_LENGTH,
                                  :maximum => EMAIL_MAXIMUM_LENGTH,
                                  :message => EMAIL_LENGTH_MESSAGE }
    validates :email, :format => { :with => EMAIL_FORMAT,
                                  :message => EMAIL_FORMAT_MESSAGE }

    validates :password, :length => { :minimum => PASSWORD_MINIMUM_LENGTH,
                                      :maximum => PASSWORD_MAXIMUM_LENGTH,
                                      :message => PASSWORD_LENGTH_MESSAGE },
                         :allow_nil => true

    validate :confirm_password, :unless => :password_nil?

    before_save :encrypt_password
    before_save { |role| role.email = role.email.downcase }

    def self.authenticate( email, password )
        role = find_by_email( email )    
        if role and role.password == Role.digest( password )
            role
        else
            nil
        end 
    end

    # Calls geolocation search and filters if search params exist
    def self.search( params )
        role_ids = Geolocation.find_nearest(params[:limit], params[:max_distance], params[:role_id])
        roles = Array.new
        role_ids.each do |id|
            roles.push(Role.find(id))
        end
        filter(:roles => roles, :search => params[:search])
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


    # Filters results based on search params
    # TODO finish   
    def filter( params )
        roles = params[:roles]
        good_roles = Array.new   
        good_roles = roles     
=begin
        profiles.each do |profile| 
            match = true
            #Remove all where ambitions don't match
            unless ambitions.nil?
                ambitions.each do |ambition|
                    unless profile.ambitions.include?(ambition)
                        match = false
                    end
                end
            end

            unless skills.nil?
                #Remove all where skills don't match
                skills.each do |skill| 
                    unless profile.tag_list.include?(skill)
                        match = false
                    end
                end
            end

            if match
                good_profiles.push(profile)
            end
        end
=end
        good_roles
    end

end
