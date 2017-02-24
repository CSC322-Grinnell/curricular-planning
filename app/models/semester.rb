class Semester < ActiveRecord::Base
  has_many :offering, inverse_of: :semester
end
