class Staff < ActiveRecord::Base
  belongs_to :user
  belongs_to :position
  has_many :responses
  has_and_belongs_to_many :bootcamps
end
