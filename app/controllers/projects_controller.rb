class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :correct_project_mate, only: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def teammates
    @project = Project.find(params[:project_id])
    @users = @project.mates
    render "teammates"
  end

  def team_index
    @project = Project.find(params[:project_id])
    @users = User.non_mates(@project).page(params[:page])
    render "team_index"
  end


  # GET /projects
  # GET /projects.json
  def index
    @my_projects = current_user.projects
    @mate_projects = current_user.mate_projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tasks = Task.where(project_id: params[:id])
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def render_404
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :title, :content, :client_id, :client)
    end
    
    def correct_user
      @Project = Project.find(params[:id])
      if current_user != @project.user
        redirect_to root_path
      end
    end

    def correct_project_mate
      @Project = Project.find(params[:id])
      unless current_user == @project.user || @project.mates.include?(current_user)
        redirect_to root_path
      end
    end
end
