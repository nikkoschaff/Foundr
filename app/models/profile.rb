class Profile < ActiveRecord::Base
    attr_accessible :about, :name, :headline, :tag_list
    acts_as_taggable

    has_one :geolocation
    has_one :role


    validates :about, :length => { :maximum => 140,	:message => "About must be at most 140 characters" }

    validates :headline, :length => { :maximum => 28, :message => "Headline must be at most 28 characters" }

    has_and_belongs_to_many :ambitions
end
