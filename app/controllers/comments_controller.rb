class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment saved!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: comment, vote: params[:vote], user: current_user)
    
    if @vote.valid?
      flash[:notice] = "Thanks for your vote!"
    else
      flash[:error] = "You already voted for this comment."
    end  
    redirect_to :back
  end
end