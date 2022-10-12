class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comments = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create

    @comments      = Comment.create(comment_params)
    @comments.user = current_user
    @comments.post = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])

    if @comments.save
    respond_to do |format|
          format.html { redirect_to user_group_post_path(current_user, @post.group, @comments.post), notice: "Comment Created" }
    end
    else

    end
    end

  private

  def comment_params

    params.require(:comment).permit(:content, :user_id, :post_id)

  end
end

