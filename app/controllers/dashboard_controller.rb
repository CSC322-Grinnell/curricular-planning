class DashboardController < ApplicationController
  def get
    @semesters = Semester.all
  end
end
