class Geolocation < ActiveRecord::Base
  attr_accessible :accuracy, :latitude, :longitude, :role_id

  has_one :role

  validates_uniqueness_of :role_id

  	# Finds nearest locations within max distance and limit of location at role
	# limit => max number allowed
	# max_distance => minimum distance in km
	# role_id => id of current sessions role
	# Return: Array of role ids
	def self.nearest_roles(limit, max_distance, role_id, ambitions=nil, tag_list=nil)
		# TODO implement later with sockets
		#grid = Grid.new
		# TODO search filtering
		#grid.nearest_role_ids( limit, max_distance, role_id,
		#				 current_geolocation.latitude,
		#				 current_geolocation.longitude,
		#				 ambitions, tag_list )

		# CURRENT ALGORITHM - Retrieve all DB entries, haversine distance for relative distance
		# => sort by distance, cut off after distance > max_distance

		# --- NOT SCALABLE IN THE SLIGHTEST!!!!! ---
		current = Geolocation.where("role_id=?",role_id).last
		locations = Geolocation.find( :all, :conditions => ["id!=?",role_id] )
		locations_with_distance = []

		# Find distance from center for each location
		locations.each do |loc|
			locations_with_distance.push( { :id => loc.role_id,
			 :distance => Geolocation.haversine_distance(role_id,loc.role_id) } )
		end

		sorted_locations = locations_with_distance.sort_by { |loc| loc[:distance] }
		@roles = []
		sorted_locations.each do |loc|
			if loc[:distance] > max_distance
				break
			else
				@roles.push(Role.find(loc[:id]))
			end
		end
		@roles
	end

	# Find distance between two points based on a spherical Earth
	# Copy of one from Grid, used here for convenience
	def self.haversine_distance( user_id, other_id )
		user = Geolocation.where("role_id=?",user_id).first
		other = Geolocation.where("role_id=?",other_id).first
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
		dMi = (0.621371 * dKm).round(1)
	end	

end