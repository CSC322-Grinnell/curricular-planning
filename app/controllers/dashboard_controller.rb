class DashboardController < ApplicationController
  def get
    @semesters = Semester.all
  end

  def post
    if params[:request] == "newSemester"
      if params[:year] and params[:term]
        @semester = Semester.new(academic_year: params[:year], academic_term: params[:term])
        @semester.save
      end
    end
    redirect_to "/dashboard"
  end
end
