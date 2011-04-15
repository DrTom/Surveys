class Virtualdesktop < ActiveRecord::Base
  belongs_to :user
  belongs_to :masterimage

  validates_uniqueness_of :name
  validates_presence_of  :name, :masterimage

  def rundown!
    if not rundown
      self.rundown= DateTime.now 
      self.user_id= nil 
      self.save!
    end
  end 

  def down?
    rundown ? true : false
  end

end
