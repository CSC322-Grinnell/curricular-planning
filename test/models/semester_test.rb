require 'test_helper'
require 'minitest/autorun'

class SemesterTest < ActiveSupport::TestCase
  test "count of fixtures" do
    assert_equal 3, Semester.count # loaded from fixtures
  end

  test "validity of fixtures" do
    sems = Semester.all
    sems.each do |sem|
      assert sem.valid?
    end
  end

  test "validity when saving new semester" do
    sem = Semester.new
    assert_not sem.valid?
    sem.academic_year= "2018/2019"
    assert_not sem.valid?
    sem.academic_term= "Fall"
    assert sem.valid?
  end
end
