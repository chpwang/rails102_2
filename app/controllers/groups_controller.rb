class GroupsController < ApplicationController
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    
    if @group.save
      redirect_to groups_path
    else
      render :new
    end


  end

  def show
    @group = Group.find(params[:id])
  end

  def edit

  end

  def update

    if @group.update(group_params)
      redirect_to groups_path
    else
      render :new
    end
  end

  def destroy
    
    @group.destroy

    redirect_to groups_path, alert: "Group Deleted"
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_check_permission
    @group = Group.find(params[:id])
  end
end
