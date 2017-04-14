class DashboardController < ApplicationController

  def get
    if user_signed_in? and User.current_user.signed_in?
      @semesters = Semester.all
      @user = User.current_user
      @selected_offerings = @user.offering
    else
      flash[:notice] = "Log in to access the dashboard"
      redirect_to "/"
    end
  end

  def post
    case params[:request]
    when "newSemester"
      flash[:notice] = "New Semester Created" if handleNewSemester
    when "newCourse"
      flash[:notice] = "New Course Created" if handleNewCourse
    when "newOffering"
      flash[:notice] = "New Offering Created" if handleNewOffering
    when "newStudentInterest"
      flash[:notice] = "New Student Interest Created" if handleNewStudentInterest
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

  def handleNewStudentInterest
    if params.require(:offering)
      user.offering = Offering.find(params[:offering])
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
      offering.semester = Semester.find(params[:semester])
      offering.course = Course.find(params[:course])
      return offering.save
    end
  end
end
