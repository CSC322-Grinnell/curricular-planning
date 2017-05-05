class CourseController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    redirect_to :dashboard unless User.current_user.has_role? :admin
    setCourse
  end
  
  def post 
    redirect_to :dashboard unless User.current_user.has_role? :admin
    setCourse
    
    case params[:request]
    when "editCourse"
      flash[:notice] = "Course Saved" if handleEditCourse
    end
    redirect_to '/course/' + @course.id.to_s
  end
  
  private

  def handleEditCourse
    requiredParams = [:course_number, :title, :description]
    # check if all required parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      @course.course_number= params[:course_number]
      @course.title= params[:title]
      @course.description= params[:description]
      return @course.save
    end
  end
  
  def setCourse
    if params[:id]
      @course = Course.find params[:id]
    else 
      redirect_to :dashboard
    end
  end
end