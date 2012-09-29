class Ambition < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true

  #Many-many connection with profiles
  has_many :profiles_ambitions, :foreign_key => ":ambition_id"
  has_many :profiles, :through => :profiles_ambitions
end
