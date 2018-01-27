class Account::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts.recent.paginate(page: params[:page], per_page: 4)
  end

  def edit
  end

  def update

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Post Successfully Updated"
    else
      render :edit
    end
  end

  def destroy

    @post.destroy

    redirect_to account_posts_path, alert: "Post Deleted"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end


  def find_post_and_check_permission
    @post = Post.find(params[:id])

    if @post.user != current_user
      redirect_to account_posts_path, alert: "You have no permission"
    end
  end

end
