class DashboardController < ApplicationController

  def get
    @semesters = Semester.all
  end

  def post
    case params[:request]
    when "newSemester"
      flash[:notice] = "New Semester Created" if handleNewSemester
    when "newCourse"
      flash[:notice] = "New Course Created" if handleNewCourse
    end
    redirect_to "/dashboard"
  end

  private

  def handleNewSemester
    if params.require(:year) and params.require(:term)
      semester = Semester.new(academic_year: params[:year], academic_term: params[:term])
      return semester.save
    end
  end

  def handleNewCourse
    requiredParams = [:course_number, :title, :description]
    # check if all requried parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      course = Course.new(course_number: params[:course_number],
                          title: params[:title],
                          description: params[:description],
                          required: params[:required])
      return course.save
    end
  end

end
