module ProfilesHelper
	def profile_distance( profile1, profile2 )
		# Distances between two
		lat1 = profile1.geolocation.latitude
		lon1 = profile1.geolocation.longitude
		lat2 = profile2.geolocation.latitude
		lon2 = profile2.geolocation.longitude
		profile_haversine_distance( lat1, lon1, lat2, lon2 )
	end

	def profile_haversine_distance( lat1, lon1, lat2, lon2 )
		rAD_PER_DEG = 0.017453293  #  PI/180

		rkm = 6371              # radius in kilometers...some algorithms use 6367

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

		dKm = rkm * c             # delta in kilometers

		# Return mile-form distance to user
		profile_meters_to_miles( dKm )
	end	

	def profile_meters_to_miles( valMeters )
		miles = valMeters * 0.62137119
		miles
	end

	def profile_filter( skills, ambitions, profiles = Array.new )
		good_profiles = Array.new

		profiles.each do |profile| 
			match = true
			#Remove all where ambitions don't match
			ambitions.each do |ambition|
				unless profile.ambitions.include?(ambition)
					match = false
				end
			end
			#Remove all where skills don't match
			skills.each do |skill| 
				unless profile.tag_list.include?(skill)
					match = false
				end
			end
			if match
				good_profiles.push(profile)
			end
		end
		good_profiles
	end


	# Radius in KM
	def profile_find_nearest( profile, radius )
		# TODO (big one)
		nil
	end
end