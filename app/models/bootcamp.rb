class Bootcamp < ActiveRecord::Base
  belongs_to :location
  has_many :responses
  has_many :surveys, through: :responses
  has_and_belongs_to_many :staffs
end
