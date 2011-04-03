class User < ActiveRecord::Base

  has_many :virtualdesktops
  has_many :questionnaires

  validates_uniqueness_of :uid

  def name
    self.uid
  end

end
