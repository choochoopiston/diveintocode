class SubmitRequestsController < ApplicationController
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy, :approve, :unapprove, :reject]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :correct_user1, only: [:index, :new, :inbox, :create]
  before_action :after_approve, only: [:edit, :update, :destroy]
  before_action :after_unapprove, only: [:edit, :update]
  
  
  def index
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def new
    @users = current_user.each_other_follows
    @tasks = Task.where.not(status: 1..3).where(user_id: current_user.id, done: false)
    @submit_request = current_user.submit_requests.build(status: 1)
    @user = @submit_request.user
  end

  def create
    @submit_request = SubmitRequest.new(submit_request_params)
    respond_to do |format|
      if @submit_request.save
         @submit_request.task.update_attribute(:status, 1)
         @submit_request.task.update_attribute(:charge_id, submit_request_params[:charge_id])
         format.html { redirect_to @submit_request, notice: 'SubmitRequest was successfully created.' }
         format.json { render :show, status: :create, location: @submit_request }
      else
        format.html { render :new }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
    @users = current_user.each_other_follows
    @task = Task.find(@submit_request.task_id)
  end

  def update
    respond_to do |format|
      if @submit_request.update(submit_request_params)
         @submit_request.task.update_attribute(:charge_id, submit_request_params[:charge_id])
         format.html { redirect_to @submit_request, notice: 'タスク依頼は修正されました。' }
         format.json { render :show, status: :ok, location: @submit_request }
      else
         format.html { render :edit }
         format.json { render jason: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submit_request.task.update_attribute(:status, 0)
    @submit_request.task.update_attribute(:charge_id, @submit_request.user_id)
    @submit_request.destroy
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.html { redirect_to user_submit_requests_path(@submit_request.user), notice: 'タスク依頼は削除されました。' }
      format.js
    end
  end

  def approve
    @submit_request.update_attribute(:status, 2)
    @submit_request.task.update_attribute(:status, 2)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  def unapprove
    @submit_request.update_attribute(:status, 9)
    @submit_request.task.update_attribute(:status, 9)
    @submit_request.task.update_attribute(:charge_id, @submit_request.user_id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  def reject
    @submit_request.update_attribute(:status, 8)
    @submit_request.task.update_attribute(:status, 8)
    @submit_request.task.update_attribute(:charge_id, @submit_request.user_id)
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  def inbox
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).where.not(status: 8).order("updated_at DESC")
  end
  
  private
    def submit_request_params
      params.require(:submit_request).permit(:task_id, :user_id, :charge_id, :status, :message)
    end
    
    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

    def correct_user
      @submit_request = SubmitRequest.find(params[:id])
      redirect_to root_path unless current_user == @submit_request.user
    end
    
    def correct_user1
      @user = User.find(params[:user_id])
      redirect_to root_path unless current_user == @user
    end
    
    def after_approve
      @submit_request = SubmitRequest.find(params[:id])
      redirect_to root_path if @submit_request.status  == 2
    end
    
    def after_unapprove
      @submit_request = SubmitRequest.find(params[:id])
      redirect_to root_path if @submit_request.status  == 9 || @submit_request.status  == 8
    end
    
end
