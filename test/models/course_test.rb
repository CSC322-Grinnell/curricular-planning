require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "count of fixtures" do
    assert_equal 4, Course.count # loaded from fixtures
  end

  test "validity of fixtures" do
    courses = Course.all
    courses.each do |course|
      assert course.valid?
    end
  end

  test "validity when saving new course" do
    c = Course.new
    assert_not c.valid?
    c.course_number= "CSC 261"
    assert_not c.valid?
    c.title= "AI"
    assert_not c.valid?
    c.required= false
    assert c.valid?
  end
end
