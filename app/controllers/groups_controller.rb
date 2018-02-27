class GroupsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource find_by: :slug, except: :new

  def show
  end

  def new
    @group = Group.new user_groups: [current_user.user_groups.build(role: :admin)], project_id: params[:project_id] if current_user
    authorize! :read, @group
  end

  def create
    if @group.save
      redirect_to [@project, @group]
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit :project_id, :name, user_groups_attributes: %i[id user_id role]
  end
end
