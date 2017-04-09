class Semester < ActiveRecord::Base
  resourcify
  has_many :offering, inverse_of: :semester
  validates :academic_year, :academic_term, presence: true
end
