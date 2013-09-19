class Survey < ActiveRecord::Base
  has_many :responses
  has_many :bootcamps, through: :responses
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true
end
