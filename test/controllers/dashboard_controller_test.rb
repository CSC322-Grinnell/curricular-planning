require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  tests DashboardController

  test "post create new course" do
    initialNumberCourses = Course.count
    post :post,
      request: "newCourse",
      course_number: "161",
      title: "Functional",
      description: "This is the description",
      required: true
    assert_equal initialNumberCourses + 1, Course.count
  end

  test "post create new semester" do
    initialNumberSemesters = Semester.count
    post :post,
      request: "newSemester",
      term: "my term",
      year: "my year"
    assert_equal initialNumberSemesters + 1, Semester.count
  end

end

