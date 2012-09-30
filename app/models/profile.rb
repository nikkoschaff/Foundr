class Profile < ActiveRecord::Base
    attr_accessible :about, :name, :headline, :tag_list
    acts_as_taggable

    has_one :geolocation
    has_one :role

    validates :about, :length => { :maximum => 140,	:message => "About must be at most 140 characters" }

    validates :headline, :length => { :maximum => 28, :message => "Headline must be at most 28 characters" }

    validates :name, :length => { :maximum => 13, :message => "Name must be at most 13 characters" }

	#Many-many connection with ambitions
	has_many :profiles_ambitions, :foreign_key => ":profile_id"
	has_many :ambitions, :through => :profiles_ambitions
end
