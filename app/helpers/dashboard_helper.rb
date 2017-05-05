module DashboardHelper
    
    def is_admin? 
        User.current_user.has_role? :admin
    end
    
    def course_detail_link(course)
        return "/course/" + course.id.to_s
    end
end
