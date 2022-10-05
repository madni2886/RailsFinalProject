class CommentsController < ApplicationController
  def new
    @comments=Comment.new
  end


  def index
    @comments=Comment.all
  end
  def create

    @comments=Comment.new(comment_params)
    @comments.user= current_user
    @comments.post= Post.find(params[:post_id])
    @post= Post.find(params[:post_id])
    respond_to do |format|
      if @comments.save
        format.html { redirect_to user_group_post_path(current_user,@post.group,@comments.post), notice: "Comment Created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end



  private
  def comment_params
    params.require(:comment).permit(:comment,:user_id,:post_id)

  end
end

