require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  
   test "Accounts with grinnell.edu domain should be found" do 
    initialNumberUsers = User.count
    correct_domain_signup
    assert_equal initialNumberUsers + 1, User.count 
  end 

  test "Accounts without grinnell.edu domain should not be found" do 
    initialNumberUsers = User.count
    erroneous_domain_signup
    assert_equal initialNumberUsers, User.count 
  end 
end 