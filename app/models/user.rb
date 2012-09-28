class User < ActiveRecord::Base
  attr_accessible :about, :email, :headline, :name, :password, :password_confirmation

  has_many :ambitions
  has_many :skills  
  has_one :geolocation

  #TODO Profile picture
  #TODO Link to fb
  #TODO Link to twitter
  #TODO Link to linkedin

end
