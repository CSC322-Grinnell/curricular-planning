class Offering < ActiveRecord::Base
  resourcify
  belongs_to :course, inverse_of: :offering
  validates_associated :course
  belongs_to :semester, inverse_of: :offering
  validates_associated :semester
  has_and_belongs_to_many :user
  validates :professor, :time, :capacity, :course, :semester, presence: true, uniqueness: { scope: [:professor, :time]}
  
end
