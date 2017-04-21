class Course < ActiveRecord::Base
  resourcify
  has_many :offering, inverse_of: :course
  validates :course_number, :title, presence: true, uniqueness: { scope: [:course_number, :title]}
  validates_inclusion_of :required, in: [true, false]
  
  def getName 
    return course_number + " - " + title
  end
end
