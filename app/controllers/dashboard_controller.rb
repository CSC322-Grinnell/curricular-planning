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
    when "newOffering"
      handleNewOffering
    end
    redirect_to "/dashboard"
  end

  private

  def handleNewSemester
    if params.require(:year) and params.require(:term)
      semester = Semester.new(academic_year: params[:year], academic_term: params[:term])
      semester.save if semester.valid?
    end
  end

  def handleNewCourse
    requiredParams = [:course_number, :title, :description]
    # check if all required parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      course = Course.new(course_number: params[:course_number],
                          title: params[:title],
                          description: params[:description],
                          required: !!params[:required])
      course.save if course.valid?
    end
  end

  def handleNewOffering
    requiredParams = [:professor, :time, :capacity, :course, :semester]
    # check if all required parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      offering = Offering.new(professor: params[:professor],
                          time: params[:time],
                          capacity: params[:capacity].to_i)
      offering.semester= Semester.find(params[:semester])
      offering.course= Course.find(params[:course])
      offering.save if offering.valid?
    end
  end
end