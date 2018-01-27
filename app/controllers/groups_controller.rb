class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    
    if @group.save
      redirect_to groups_path
    else
      render :new
    end

  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(page: params[:page], per_page: 4)
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


  def join
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      redirect_to group_path(@group), warning: "你已经是本讨论组成员，无需重复加入"
    else
      current_user.join!(@group)
      redirect_to group_path(@group), notice: "已成功加入本讨论组"
    end
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      redirect_to group_path(@group), alert: "已退出本讨论组"
    else
      redirect_to group_path(@group), warning: "不在本讨论组里，无法退出"
    end
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
