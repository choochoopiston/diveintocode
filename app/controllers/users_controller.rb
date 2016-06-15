class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def following
    @user = User.find(params[:id])
    render 'following'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'follwers'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :description, :image, :image_cache, :remove_image)
    end
end
