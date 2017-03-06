class DashboardController < ApplicationController
  def get
    @semesters = Semester.all
  end

  def post
    if params[:action] == "newSemester"
      if params[:year] and params[:term]
        Semeseter.new(academic_year: params[:year], academic_term: params[:term])
      end
    end
    redirect_to get
  end
end
