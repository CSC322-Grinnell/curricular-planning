class OfferingController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    redirect_to :dashboard unless User.current_user.has_role? :admin
    setOffering
      
  end
  
  def post 
    redirect_to :dashboard unless User.current_user.has_role? :admin
    setOffering
    
    case params[:request]
    when "editOffering"
      flash[:notice] = "Offering Saved" if handleEditOffering
    end
    
    redirect_to '/offering/' + @offering.id.to_s
  end
  
  private

  def handleEditOffering
    requiredParams = [:professor, :section, :time, :capacity, :course, :semester]
    # check if all required parameters are present
    if requiredParams.reduce(true) {|val,x| val and params.require(x)}
      @offering.professor= params[:professor]
      @offering.section= params[:section]
      @offering.time= params[:time]
      @offering.capacity= params[:capacity].to_i
      @offering.semester = Semester.find(params[:semester])
      @offering.course = Course.find(params[:course])
      return @offering.save
    end
  end
  
  def setOffering
    if params[:id]
      @offering = Offering.find params[:id]
    else 
      redirect_to :dashboard
    end
  end
end
