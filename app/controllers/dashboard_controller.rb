class DashboardController < ApplicationController

  def get
    @semesters = Semester.all
    @selected_offerings = []
  
  end

  def post
    case params[:request]
    when "newSemester"
      flash[:notice] = "New Semester Created" if handleNewSemester
    when "newCourse"
      flash[:notice] = "New Course Created" if handleNewCourse
    when "newOffering"
      flash[:notice] = "New Offering Created" if handleNewOffering
    else 
      puts
      puts "---- REQUEST ----"
      puts params.to_s
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
                          required: !!params[:required])
      return course.save
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
      return offering.save
    end
  end
end
