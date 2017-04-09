class Ability
  include CanCan::Ability

  if user.has_role? :admin
    can :manage, :all #these will be changed according to our dashboard
  else
    can :read, :all
  end
end
