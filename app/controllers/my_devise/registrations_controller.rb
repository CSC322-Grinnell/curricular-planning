class MyDevise::RegistrationsController < Devise::RegistrationsController
    
    def create
        super
        if resource.save 
            if resource.email == "sams@sam.r"
                resource.add_role "admin"
            end 
            @ability = Ability.new(resource)
            @ability.save
        end
    end 