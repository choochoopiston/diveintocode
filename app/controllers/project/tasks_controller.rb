class Project::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def ungoodjob
  end

  def goodjob
  end

  def index
  end

  def show
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def new
    @project_task = current_user.tasks.build(project_id: params[:project_id], charge_id: current_user.id)
    @project = Project.find(params[:project_id])
  end
  
  def create
    @project_task = current_user.tasks.build(task_params)
    @project = Project.find(params[:project_id])

    respond_to do |format|
      if @project_task.save
        format.html { redirect_to project_path(@project_task.project), notice: 'Task was successfully created.' }
        
      else
        format.html { render :new }

      end
    end
  end


  def update
    @project = Project.find(params[:project_id])
    respond_to do |format|
      if @project_task.update(task_params)
        format.html { redirect_to project_path(@project_task.project), notice: 'Task was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @project_task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

    def set_project_task
      @project_task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status, :project_id)
    end
  
    def correct_user
      @task = Task.find(params[:id])
      redirect_to(user_tasks_path(current_user)) unless current_user == @task.user
    end

    
end
