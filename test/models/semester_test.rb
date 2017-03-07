require 'test_helper'
require 'minitest/autorun'

class SemesterTest < ActiveSupport::TestCase
  def test_test
    assert_equal 2, Semester.count
  end
end
