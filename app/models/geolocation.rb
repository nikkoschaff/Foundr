class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :latitude, :longitude, :profile_id

  has_one :profile

  # TODO change from profile id to role id
  validates_uniqueness_of :profile_id

  	# Finds nearest locations within max distance and limit of location at role
	# limit => max number allowed
	# max_distance => minimum distance in km
	# role_id => id of current sessions role
	# Return: Array of role ids
	def self.find_nearest(limit, max_distance, role_id)
		current_role = Role.find(role_id)
		current_geolocation = Geolocation.where("profile_id=?",current_role.id).last
		# TODO new...?  Probably where I interact with sockets....
		#grid = Grid.new
		#grid.find_nearest( limit, max_distance, role_id,
		#				 current_geolocation.latitude,
		#				 current_geolocation.longitude )
	end


	# Find distance between two points based on a spherical Earth
	# Copy of one from Grid, used here for convenience
	def self.geolocation_haversine_distance( user_id, other_id )
		user = Geolocation.find(Role.find(user_id).profile_id)
		other = Geolocation.find(Role.find(other_id).profile_id)
		lat1 = user.latitude
		lon1 = user.longitude
		lat2 = other.latitude
		lon2 = other.longitude
		# PI = 3.1415926535
		rad_per_deg = 0.017453293  #  PI/180
		# the great circle distance d will be in whatever units R is in
		rkm = 6371              # radius in kilometers...some algorithms use 6367
		dlon = lon2 - lon1
		dlat = lat2 - lat1
		dlon_rad = dlon * rad_per_deg 
		dlat_rad = dlat * rad_per_deg
		lat1_rad = lat1 * rad_per_deg
		lon1_rad = lon1 * rad_per_deg
		lat2_rad = lat2 * rad_per_deg
		lon2_rad = lon2 * rad_per_deg
		a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
		dKm = rkm * c             # delta in kilometers
		dKm

		
	end	

end