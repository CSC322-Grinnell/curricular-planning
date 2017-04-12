class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:admin)
      can [:edit, :delete, :new, :create, :update, :destroy], [Course, Offering, Semester] 
      can :read, :all
    else
   # can [:edit, :delete, :new, :create, :update, :destroy], [Enrollment]
      can :read, :all
    end
  end
end