class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_admin_or_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|post| post.vote_total}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to posts_path
    else #validation error
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully!"
      redirect_to posts_path
    else #validation error
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, vote: params[:vote], user: current_user)
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Thanks for your vote!" 
        else
          flash[:notice] = "You already voted for this post."
        end
        redirect_to :back
      end
      format.js
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_admin_or_creator
    access_denied unless logged_in? && (current_user.admin? || @post.user == current_user)
  end
end
