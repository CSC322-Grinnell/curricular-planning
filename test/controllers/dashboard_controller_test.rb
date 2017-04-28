require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  tests DashboardController



  test "A properly formatted POST request to the DashboardController should create a corresponding Course" do
    admin_signin

    initialNumberCourses = Course.count
    number = "161"
    title = "Functional"
    description = "description"
    required = true
    post :post,
      request: "newCourse",
      course_number: number,
      title: title,
      description: description,
      required: required
    assert_response :found
    assert_equal initialNumberCourses + 1, Course.count
    assert_not_nil Course.find_by(course_number: number, title: title, description: description, required: required)
  end

  test "A properly formatted POST request to the DashboardController should create a corresponding semester" do
    admin_signin

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

  test "A properly formatted POST request to the DashboardController should create a corresponding Offering" do
    admin_signin

    initialNumberOfferings = Offering.count
    professor = "Prof"
    time = "in the morning"
    capacity = 25
    course = Course.all[0].id
    semester = Semester.all[0].id
    post :post,
      request: "newOffering",
      professor: professor,
      time: time,
      capacity: capacity,
      course: course,
      semester: semester
    assert_response :found
    assert_equal initialNumberOfferings + 1, Offering.count
    assert_not_nil Offering.find_by(professor: professor, time: time, capacity: capacity, course_id: course, semester_id: semester)
  end

end
