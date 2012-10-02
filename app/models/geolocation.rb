class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :altitude, :altitude_accuracy, :latitude, :longitude, :profile_id

  has_one :profile
end
