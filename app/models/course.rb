class Course < ActiveRecord::Base
  has_many :offering, inverse_of: :course
  validates :course_number, :title, :required, presence: true
end
