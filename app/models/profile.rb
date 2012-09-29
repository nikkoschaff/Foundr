class Profile < ActiveRecord::Base
    attr_accessible :about, :email, :headline

    has_one :role
end
