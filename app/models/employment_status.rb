class EmploymentStatus < ActiveRecord::Base
  attr_accessible :status
  validates_uniqueness_of :status
  belongs_to :user
end
