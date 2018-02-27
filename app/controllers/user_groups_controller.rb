class UserGroupsController < ApplicationController
  load_and_authorize_resource :group, find_by: :slug
  load_and_authorize_resource

  def create
    redirect_to [@group.project, @group] if @user_group.save
  end

  private

  def user_group_params
    params.require(:user_group).permit :user_id, :group_id
  end
end
