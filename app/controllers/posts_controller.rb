class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @group = Group.find(params[:id])
    @post.group = @group

    if @post.save
      redirect_to groups_path(@group), notice: "Post Successfully Created"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Post Successfully Updated"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @group = @post.group

    @post.destroy

    redirect_to group_path(@group), alert: "Post Deleted"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
