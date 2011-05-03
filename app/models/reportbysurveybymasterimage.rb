class Reportbysurveybymasterimage < ActiveRecord::Base
  belongs_to :survey
  belongs_to :masterimage
end
