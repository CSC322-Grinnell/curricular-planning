class Semester < ActiveRecord::Base
  resourcify
  has_many :offering, inverse_of: :semester
  validates :academic_year, :academic_term, presence: true
  
  def getName 
    return academic_term + " " + academic_year
  end
end
