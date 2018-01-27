class Account::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def edit

  end

  def update

    if @group.update(group_params)
      redirect_to account_groups_path, notice: "更新成功"
    else
      render :new
    end
  end

  def destroy
    
    @group.destroy

    redirect_to account_groups_path, alert: "Group Deleted"
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if @group.user != current_user
      redirect_to root_path, alert: "You have no permission"
    end
  end
end
