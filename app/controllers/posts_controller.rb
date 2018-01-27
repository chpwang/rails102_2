class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @group = Group.find(params[:group_id])
    @post.group = @group

    if @post.save
      redirect_to group_path(@group), notice: "Post Successfully Created"
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Post Successfully Updated"
    else
      render :edit
    end
  end

  def destroy

    @post.destroy

    redirect_to group_path(@group), alert: "Post Deleted"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_post_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if @post.user != current_user
      redirect_to group_path(@group), alert: "You have no permission"
    end
  end

end
