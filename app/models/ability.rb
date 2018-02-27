class Ability
  include CanCan::Ability

  def initialize(user)
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    return unless user

    permission_for_common_user user
  end


  # def permission_for_(user)
  #   can :manage, Announcement
  #   can :read, User
  #   can :read, Promotion
  #   can %i[create update destroy], ProductFilter
  # end

  def permission_for_common_user(user)
    can :manage, Group, user_groups: { user_id: user.id, role: UserGroup.roles['admin'] }
    can :read, Project
    can :read, Group
    can [:create, :tutorial, :create, :update], Program, programmable_type: Group.name, programmable: { user_groups: { user_id: user.id, role: UserGroup.roles['admin'] } }
    can [:create, :tutorial, :create, :update], Program, programmable_type: User.name, programmable_id: user.id
    can [:create, :update], ProgramParam, program_parammable_type: UserGroup.name, program_parammable: { user_id: user.id }
    can [:create], UserGroup, user_id: user.id
  end
end
