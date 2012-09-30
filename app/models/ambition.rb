class Ambition < ActiveRecord::Base
  attr_accessible :name, :profiles_attributes
  validates :name, :presence => true

  has_and_belongs_to_many :profiles
  accepts_nested_attributes_for :profiles
end
