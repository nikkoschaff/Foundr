#require 'knnball'

class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :latitude, :longitude, :profile_id

  has_one :profile
=begin
  # OPTIMIZATION
  # TODO make data
  # TODO 

	# PI = 3.1415926535
	RAD_PER_DEG = 0.017453293  #  PI/180

	# the great circle distance d will be in whatever units R is in

	Rkm = 6371              # radius in kilometers...some algorithms use 6367
	Rmeters = Rkm * 1000    # radius in meters

  # limit => max number allowed
  # max_distance => minimum distance in km
  def find_nearest(limit, max_distance)
	current_location = [self.latitude, self.longitude]
	# TODO make data
	data = [{:id => 1, :point => [6.3299934, 52.32444]}]
	finder = KnnBall.build(data)
	locations = finder.nearest(current_location, limit)
	closest = find_within_distance(current_location locations, max_distance)
	closest
  end

  def find_within_distance(current_location, locations, max_distance)
  	good_locations = Array.new()
  	locations.each do |loc|
  		distance = haversine_distance(current_location.latitude,
  								current_location.longitude, 
  								loc.latitude, loc.longitude) 
  		if distance > max_distance 
  			break
  		end
  		good_locations.push(loc)
  	end
  	good_locations
  end

	def haversine_distance( lat1, lon1, lat2, lon2 )
		dlon = lon2 - lon1
		dlat = lat2 - lat1

		dlon_rad = dlon * RAD_PER_DEG 
		dlat_rad = dlat * RAD_PER_DEG

		lat1_rad = lat1 * RAD_PER_DEG
		lon1_rad = lon1 * RAD_PER_DEG

		lat2_rad = lat2 * RAD_PER_DEG
		lon2_rad = lon2 * RAD_PER_DEG

		a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
		dKm = Rkm * c             # delta in kilometers
		dKm
	end
=end

end