class User < ActiveRecord::Base
  attr_accessible :about, :email, :headline, :name, :password, :password_confirmation

  has_many :ambitions
  has_one :employment_status
  has_many :skills  


  #TODO Profile picture
  #TODO Link to fb
  #TODO Link to twitter
  #TODO Link to linkedin

end
