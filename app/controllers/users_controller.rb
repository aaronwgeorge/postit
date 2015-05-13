class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to Postit, #{@user.username}!"
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully!"
      redirect_to user_path(@user)
    else #validation error
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end
  
end