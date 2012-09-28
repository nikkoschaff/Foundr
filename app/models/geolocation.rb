class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :altitude, :altitude_accuracy, :heading, :latitude, :longitude

  belongs_to :user
end
