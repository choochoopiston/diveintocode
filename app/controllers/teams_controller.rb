class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :sameuser0, only: [:create]
  before_action :sameuser, only: [:destroy]
  respond_to :html, :js
  
  def create
    @project = Project.find(params[:project_id])
    @team = @project.teams.build(mate_id: params[:project][:user_id])
    @team.create
    respond_with @project, @team
  end

  def destroy
    @user = Project.find(params[:project_id]).mate
    @team = Team.find_by(project_id: params[:project_id], mate_id: @user.id)
    @team.destroy
    respond_with @project
  end
  
  private

    def sameuser0
      @user = User.find(params[:project][:user_id])
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
