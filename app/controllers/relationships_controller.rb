class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :sameuser0, only: [:create]
  before_action :sameuser, only: [:destroy]
  respond_to :html, :js
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.relationships.create(followed_id: params[:relationship][:followed_id])
    respond_with @user

  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @follower = Relationship.find(params[:id]).follower
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    respond_with @user, @follower
  end
  
  private

    def sameuser0
      @user = User.find(params[:relationship][:followed_id])
      if current_user.id == @user.id
        redirect_to root_path
      end
    end
  
    def sameuser
      @relationship = Relationship.find(params[:id])
      if current_user.id != @relationship.follower_id
        redirect_to root_path
      end
    end


  
end
