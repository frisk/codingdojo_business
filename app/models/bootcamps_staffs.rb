class BootcampsStaffs < ActiveRecord::Base
  belongs_to :bootcamp
  belongs_to :staff
end
