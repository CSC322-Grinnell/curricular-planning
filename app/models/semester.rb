class Semester < ActiveRecord::Base
  resourcify
  has_many :offering, inverse_of: :semester
  validates :academic_year, :academic_term, presence: true, uniqueness: { scope: [:academic_term, :academic_year]}
  
  def getName 
    return academic_term + " " + academic_year
  end
end
