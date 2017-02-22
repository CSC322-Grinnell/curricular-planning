class Offering < ActiveRecord::Base
  belongs_to :course, inverse_of: :offering
  belongs_to :semester, inverse_of: :offering
end
