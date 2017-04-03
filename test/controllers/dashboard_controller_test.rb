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

  test "A properly formatted POST request to the DashboardController should create a corresponding semester" do
    initialNumberSemesters = Semester.count
    testYear = "2017"
    testTerm = "Spring"
    post :post,
      request: "newSemester",
      term: testTerm,
      year: testYear
    assert_response :found
    assert_equal initialNumberSemesters + 1, Semester.count
    assert_not_nil Semester.find_by(academic_term: testTerm, academic_year: testYear)
  end

  test "An improperly formatted POST request to the DashboardController should not create a corresponding semester" do
    initialNumberSemesters = Semester.count
    testTerm = "Springg"

    post(:post, request: "newSemester", term:testTerm)

    assert_response :found
    assert_equal initialNumberSemesters , Semester.count
    assert_nil Semester.find_by(academic_term: testTerm)

  end
end
