class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :altitude, :altitude_accuracy, :latitude, :longitude

  has_one :profile
end
