module DashboardHelper
    
    def is_admin? 
        User.current_user.has_role? :admin
    end
    
    def showAllSemesters
        flash[:all_semesters] = true
        redirect_to :dashboard
    end
    
end
