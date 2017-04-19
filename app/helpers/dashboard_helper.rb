module DashboardHelper
    
    def is_admin? 
        User.current_user.has_role? :admin
    end
end
