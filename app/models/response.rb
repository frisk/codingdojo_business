class Response < ActiveRecord::Base
  belongs_to :bootcamp
  belongs_to :survey
  belongs_to :staff
  has_many :answers
end
