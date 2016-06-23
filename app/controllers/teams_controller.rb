class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :sameuser0, only: [:create]
  before_action :sameuser, only: [:create, :destroy]
  respond_to :html, :js
  
  def create
    @user = User.find(params[:team][:mate_id])
    @project = Project.find(params[:team][:project_id])
    @project.teams.create(mate_id: params[:team][:mate_id])
    respond_with @project, @user
  end

  def destroy
    @team = Team.find(params[:id])
    @project = @team.project
    @user = @team.mate
    @team.destroy
    respond_with @project, @user
  end
  
  private

    def sameuser0
      @user = User.find(params[:team][:mate_id])
      if current_user.id == @user.id
        redirect_to root_path
      end
    end
  
    def sameuser
      @team = Team.find(params[:id])
      if current_user.id != @team.project.user.id
        redirect_to root_path
      end
    end
end
