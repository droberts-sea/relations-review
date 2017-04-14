class Classroom < ApplicationRecord
  has_many :students
  validates :designation, presence: true
end
