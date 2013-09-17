class Bootcamp < ActiveRecord::Base
  has_many :responses
  has_many :surveys, through: :responses
  has_many :staffs, through: :responses
end
