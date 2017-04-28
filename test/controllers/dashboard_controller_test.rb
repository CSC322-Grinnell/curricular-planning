require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  tests DashboardController

  test "Admin Dashboard GET should be found" do
    admin_signin
    get :get
    assert_response 200 
  end

  test "User Dashboard GET should be found" do
    user_signin
    get :get
    assert_response 200
  end

  test "admin course deletion should be successful" do
    admin_signin

    number = "161"
    title = "Functional"
    description = "description"
    required = true
    course = Course.new(course_number:number, title: title, description: description, required: required)
    assert course.save

    initialNumberCourses = Course.count
    post :post,
      request: "deleteCourse",
      id: course.id
    assert_response :found
    assert_equal initialNumberCourses - 1, Course.count
    assert_nil Course.find_by(course_number: number, title: title, description: description, required: required)
  end

  test "user course deletion should fail" do
    number = "161"
    title = "Functional"
    description = "description"
    required = true
    course = Course.new(course_number:number, title: title, description: description, required: required)
    assert course.save

    user_signin
    initialNumberCourses = Course.count
    post :post,
      request: "deleteCourse",
      id: course.id
    assert_response :found
    assert_equal initialNumberCourses, Course.count
    assert_not_nil Course.find_by(course_number: number, title: title, description: description, required: required)
  end

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

  test "admin course creation should be successful" do
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

  test "user course creation should fail" do
    user_signin
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

  test "admin semester creation should be successful" do
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

  test "admin semester deletion should be successful" do
    testYear = "2017"
    testTerm = "Spring"

    semester = Semester.new(academic_year: testYear, academic_term: testTerm) 
    assert semester.save

    admin_signin

    initialNumberSemesters = Semester.count
    post :post,
      request: "deleteSemester",
      id: semester.id
    assert_equal initialNumberSemesters - 1, Semester.count
    assert_nil Semester.find_by(academic_term: testTerm, academic_year: testYear)
  end

  test "user semester deletion should fail" do
    testYear = "2017"
    testTerm = "Spring"

    semester = Semester.new(academic_year: testYear, academic_term: testTerm) 
    assert semester.save

    user_signin

    initialNumberSemesters = Semester.count
    post :post,
      request: "deleteSemester",
      id: semester.id
    assert_equal initialNumberSemesters, Semester.count
    assert_not_nil Semester.find_by(academic_term: testTerm, academic_year: testYear)

  end

  test "user semester creation should fail" do
    user_signin

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

  test "admin offering creation should be successful" do
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

  test "user offering creation should fail" do
    user_signin

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

  test "admin offering deletion should be successful" do

    professor = "Prof"
    time = "in the morning"
    capacity = 25
    course = Course.all[0]
    semester = Semester.all[0]

    offering = Offering.new(professor: professor, time:time, capacity:capacity)
    offering.semester = semester
    offering.course = course
    
    assert offering.save

    initialNumberOfferings = Offering.count
    admin_signin

    post :post,
      request: "deleteOffering",
      id: offering.id
    assert_equal initialNumberOfferings - 1,Offering.count 
    assert_nil Offering.find_by(professor: professor, time: time, capacity: capacity, course_id: course.id, semester_id: semester.id)
  end

  test "user offering deletion should fail" do
    professor = "Prof"
    time = "in the morning"
    capacity = 25
    course = Course.all[0]
    semester = Semester.all[0]

    offering = Offering.new(professor: professor, time:time, capacity:capacity)
    offering.semester = semester
    offering.course = course
    
    assert offering.save

    initialNumberOfferings = Offering.count
    user_signin

    post :post,
      request: "deleteOffering",
      id: offering.id
    assert_equal initialNumberOfferings,Offering.count 
    assert_not_nil Offering.find_by(professor: professor, time: time, capacity: capacity, course_id: course.id, semester_id: semester.id)
  end
end
