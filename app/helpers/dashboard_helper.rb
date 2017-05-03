module DashboardHelper
    
    def is_admin? 
        User.current_user.has_role? :admin
    end
    
    def offering_detail_link(offering)
        return "/offering/" + offering.id.to_s
    end
    
end
