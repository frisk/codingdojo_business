class Staff < ActiveRecord::Base
  has_many :responses
  has_many :bootcamps, through: :responses
end
