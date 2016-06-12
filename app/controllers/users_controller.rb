class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.flowed_users
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :description, :image, :image_cache, :remove_image)
    end
end
