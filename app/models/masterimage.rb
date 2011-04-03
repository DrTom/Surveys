class Masterimage < ActiveRecord::Base

  has_many :virtualdesktops

  validates_uniqueness_of :name

end
