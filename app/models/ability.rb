class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update
    user ||= User.new
      if user.role? :admin
        can :manage, :all
    elsif user.role? :manager
        can :read, Store
        can :read, Job
        can :read, Flavor
        can :create, StoreFlavor do |store_flavor|
            store_flavor.store_id == user.employee.current_assignment.store_id
        end
        can :destroy, StoreFlavor do |store_flavor|
            store_flavor.store_id == user.employee.current_assignment.store_id
        end
        can :create, ShiftJob do |shift_job|
            shift_job.shift.store.id == user.employee.current_assignment.store_id
        end
        can :destroy, ShiftJob do |shift_job|
            shift_job.shift.store.id == user.employee.current_assignment.store_id
        end
        can :crud, Shift do |shift|
            shift.store.id == user.employee.current_assignment.store_id
        end
        can :create, Shift do |shift|
            shift.employee.current_assignment.store.id == user.employee.current_assignment.store_id
        end
        can :read, Shift do |shift|
            shift.employee.current_assignment.store.id == user.employee.current_assignment.store_id
        end
        can :read, Employee do |employee|
            employee.current_assignment.store.id == user.employee.current_assignment.store_id
        end
        can :read, Assignment do |assignment|
            assignment.store.id == user.employee.current_assignment.store_id
        end

   #   band.id == user.band_id
   # endß
 #elsif user.role? :manager
  #  can :update, Band do |band|  
   #   band.id == user.band_id
   # end
   # can :destroy, Band do |band|  
   #   band.id == user.band_id
   # end
  #elsif user.role? :member
  #  can :update, Band do |band|  
  #    band.id == user.band_id
  #  end
  #end
    elsif user.role? :employee
        can :read, Store
        can :read, Job
        can :read, Flavor
        can :update, Employee do |employee|
          employee.id == user.employee_id
        end
        can :update, User do |u|
          u.id == user.id
        end
        can :read, Employee do |employee|  
          employee.id == user.employee_id
        end
        can :read, User do |u|
          u.id == user.id
        end
        can :read, Shift do |shift|
          shift.employee == user.employee
        end
        can :read, ShiftJob do |shift_job|
          shift_job.shift.employee == user.employee
        end 
    else
        can :read, Store do |store|
          store.active == true
        end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #  can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
