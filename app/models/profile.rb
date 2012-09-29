class Profile < ActiveRecord::Base
  attr_accessible :about, :email, :headline
end
