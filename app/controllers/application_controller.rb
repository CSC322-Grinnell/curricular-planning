class ApplicationController < ActionController::Base
  protected
  
  before_filter :set_current_user

  def set_current_user
    User.current_user = current_user
  end

  def after_sign_in_path_for(resource)
    get '/dashboard'
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
