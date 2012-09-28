# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seed employment status
Employment_Status.create!( :status => "Employed" )
Employment_Status.create!( :status => "Unemployed" )
Employment_Status.create!( :status => "Self-employed" )

# Seed ambitions
Ambition.create!( :name => "Build my team" )
Ambition.create!( :name => "Join a team" )
Ambition.create!( :name => "Networking" )
Ambition.create!( :name => "Not looking" )
