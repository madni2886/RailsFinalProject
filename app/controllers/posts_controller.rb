class PostsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @post=Post.all
  end

  def new
    @group = Group.find(params[:group_id])
    @post=@group.posts.new
  end
  def create
    @group = Group.find(params[:group_id])
    @post = @group.posts.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_group_path(current_user,@group), notice: "Atricle was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  def edit

  end

  def show
    @post=@group.posts.all
  end
  private
  def get_group
    @group = current_user.groups.find(params[:group_id])
  end
  def post_params
    params.require(:post).permit(:title, :description)
  end

end