class Offering < ActiveRecord::Base
  belongs_to :course, inverse_of: :offering
  validates_associated :course
  belongs_to :semester, inverse_of: :offering
  validates_associated :semester
  validates :professor, :time, :capacity, presence: true
end
