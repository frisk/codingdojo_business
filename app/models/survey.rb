class Survey < ActiveRecord::Base
  has_many :responses
  has_many :bootcamps, through: :responses
  has_many :questions
end
