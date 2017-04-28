class DashboardController < ApplicationController

  before_filter :authenticate_user!
  
  def get
    if User.current_user.has_role?(:admin) and flash[:all_semesters] 
      @semesters = Semester.all
      @all_semesters = true
    else 
      @semesters = Semester.where(archived: false)
      @all_semesters = false
    end
    @semesters = @semesters.order(:academic_year, :academic_term)
    @user = User.current_user
    @selected_offerings = @user.offering
    @courses = Course.all
  end

  def post
    # for all users
    case params[:request]
    when "pickCourse"
      flash[:notice] = "Course Selections Updated" if handlePickCourse
    end
    
    # for admin only
    if User.current_user.has_role? :admin
      case params[:request]
      when "newSemester"
        flash[:notice] = "New Semester Created" if handleNewSemester
      when "newCourse"
        flash[:notice] = "New Course Created" if handleNewCourse
      when "newOffering"
        flash[:notice] = "New Offering Created" if handleNewOffering
      when  "deleteOffering"
        flash[:notice] = "Offering Deleted" if handleDeleteOffering
      when "deleteCourse"
        flash[:notice] = "Course Deleted" if handleDeleteCourse
      when "archiveSemesterToggle"
        flash[:notice] = "Semester Archive Changed" if handleArchiveSemesterToggle
      end
      flash[:all_semesters] = (params[:all_semesters] == 'true')
    end
    redirect_to :dashboard
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
      offering.semester = Semester.find(params[:semester])
      offering.course = Course.find(params[:course])
      return offering.save
    end
  end
  
  def handlePickCourse
    if params.require(:offerings)
      user = User.current_user
      user.offering.clear
      params[:offerings].each do |id, val|
        if val == "1"
          offering = Offering.find id
          user.offering.push offering
        end
      end
    end
  end 
  
  def handleDeleteOffering
    Offering.destroy params[:id]
    return !Offering.exists?(params[:id]) 
  end
  
  def handleDeleteCourse
    # delete all the offerings related to course
    course = Course.destroy params[:id]
    return false unless course
    course.offering.each do |offering|
      offering.destroy
    end
    # delete course
    course.destroy
    return !Course.exists?(params[:id]) #verify deleted
  end
  
  def handleArchiveSemesterToggle
    semester = Semester.find(params[:id])
    return false unless semester
    semester.archived= !semester.archived
    return semester.save
  end
end
