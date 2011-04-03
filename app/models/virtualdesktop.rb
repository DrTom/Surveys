class Virtualdesktop < ActiveRecord::Base
  belongs_to :user
  belongs_to :masterimage

  validates_uniqueness_of :name
end
