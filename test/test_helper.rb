require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'

# Improved Minitest output (color and progress bar)
require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter)

def admin_signin
  @user = User.create(email:"fixture@grinnell.edu", password: Devise::Encryptor.digest(User, "helloworld"))
  @user.add_role :admin
  sign_in @user
end

def user_signin
  @user = User.create(email:"student@grinnell.edu", password: Devise::Encryptor.digest(User, "password"))
  sign_in @user
end

def correct_domain_signup
  @user = User.create(email:"example@grinnell.edu", password: Devise::Encryptor.digest(User, "password"))
  sign_in @user
end 

def erroneous_domain_signup
  @user = User.create(email:"example@bad.com", password: Devise::Encryptor.digest(User, "password"))
  sign_in @user
end 

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
