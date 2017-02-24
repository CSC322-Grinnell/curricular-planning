class Course < ActiveRecord::Base
  has_many :offering, inverse_of: :course
end
