class ApplicationController < ActionController::Base
  protected
  
  before_filter :set_current_user

  def set_current_user
    User.current_user = current_user
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
