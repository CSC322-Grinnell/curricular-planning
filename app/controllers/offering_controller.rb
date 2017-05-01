class OfferingController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    setOffering
      
  end

  def edit
  end
  
  private 
  
  def setOffering
    @offering = Offering.find params[:id]
  end
end
