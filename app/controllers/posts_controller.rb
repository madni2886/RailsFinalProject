class PostsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] ="User not found"
    redirect_back(fallback_location: root_path)

  end
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
  def show_posts
    @post=Post.all

  end
  def edit
  end

  def show

    @group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:id])
  end
  private
  def get_group
    @group = current_user.groups.find(params[:group_id])
  end
  def post_params
    params.require(:post).permit(:title, :description)
  end

end
