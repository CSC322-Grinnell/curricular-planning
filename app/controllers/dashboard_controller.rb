class DashboardController < ApplicationController
  def get
    @semesters = Semester.all
  end

  def post
    case params[:request]
    when "newSemester"
      handleNewSemester
    when "newCourse"
      handleNewCourse
    end
    redirect_to "/dashboard"
  end

  private

  def handleNewSemester
    if params[:year] and params[:term]
      semester = Semester.new(academic_year: params[:year], academic_term: params[:term])
      semester.save if semester.valid?
    end
  end

  def handleNewCourse
    requiredParams = [:course_number, :title, :description, :required]
    # check if all requried parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      course = Course.new(course_number: params[:course_number],
                          title: params[:title],
                          description: params[:description],
                          required: params[:required])
      course.save if course.valid?
    end
  end

end
