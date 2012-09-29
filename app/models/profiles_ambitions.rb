class ProfilesAmbitions < ActiveRecord::Base
  attr_accessible :profile_id, :ambition_id

  belongs_to :profiles
  belongs_to :ambitions

  validates :profile_id, :presence => true
  validates :ambition_id, :presence => true
end
