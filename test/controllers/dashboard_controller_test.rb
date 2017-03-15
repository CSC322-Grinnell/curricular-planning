require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  
  test "post create new course" do
    initialNumberCourses = Course.count
    post :dashboard, 
      request: "newCourse",
      course_number: "161", 
      title: "Functional", 
      description: "This is the description",
      required: true
    assert_response :ok
    assert_equal initialNumberCourses + 1, Course.count
  end
  
end
