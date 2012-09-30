# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Load ambitions
unless Ambition.find_by_id(3)
	Ambition.create!(:name => "Build my team")
	Ambition.create!(:name => "Join a team")
	Ambition.create!(:name => "Networking")
end

# Load admin role
unless Role.find_by_id(1)
	Role.create!(:email => "admin@foundrapp.com", :password => "qwertyuiop", :password_confirm => "qwertyuiop")
end

# Load admin profile
unless Profile.find_by_id(1)
	Profile.create!(:name => "admin", :headline => "admin", :about => "admin")
end


@role = Role.find(1)
@role.build_profile(:name => "admin", :headline => "admin", :about => "admin")
@role.save!
