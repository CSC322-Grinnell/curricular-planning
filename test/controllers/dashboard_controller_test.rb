require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  tests DashboardController

  test "A properly formatted POST request to the DashboardController should create a corresponding semester" do

    post(:post, 
    assert_response :found
    assert_not_nil Semester.find_by(
  
  end
end

