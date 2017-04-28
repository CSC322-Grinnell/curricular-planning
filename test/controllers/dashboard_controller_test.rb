require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  tests DashboardController

  test "Student Interest Input: Properly formed POST request" do
    oid = Offering.all[0].id

    user_signin
    post :post,
      request: "pickCourse",
      offerings: {"#{oid}":"1"}
    assert_response :found
    assert @user.offering.include? Offering.all[0]
    post :post,
      request: "pickCourse",
      offerings: {"#{oid}":"0"} 

    assert_response :found
    assert (not @user.offering.include? Offering.all[0])
  end

  test "Admin: POST Course Create Successful" do
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

  test "User: POST Course Create Failure" do
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
    assert_equal initialNumberCourses, Course.count
  end

  test "Admin: POST Semester Create Sucessful" do
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

  test "User: POST Semester Create Failure" do
    initialNumberSemesters = Semester.count
    testYear = "2017"
    testTerm = "Spring"
    post :post,
      request: "newSemester",
      term: testTerm,
      year: testYear
    assert_response :found
    assert_equal initialNumberSemesters, Semester.count

  end

  test "Admin: POST Offering Create Successful" do
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

  test "User: POST Offering Create Failure" do
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
    assert_equal initialNumberOfferings, Offering.count
  end
end
