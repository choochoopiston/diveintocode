class Taskline::TasksController < ApplicationController
  def ungoodjob
  end

  def goodjob
    #該当のタスクへの自分がグッジョブした件数をカウント
    gdcount = Goodjob.where(task_id: goodjob_params[:task_id], user_id: current_user.id).count
    if gdcount == 0 then
      #過去に自分がグッジョブしていなければそのまま新規登録(INSERT文)
      @gjb = Goodjob.create(user_id: current_user.id, task_id: goodjob_params[:task_id], number: 1)
    else
      #過去に自分がグッジョブしていなければカウントアップして追加登録(UPDATE文）
      @gjb = Goodjob.find_by(user_id: current_user.id, task_id: goodjob_params[:task_id])
      @gjb.number = @gjb.number + 1
      @gjb.update(user_id: current_user.id)
    end
    @gjb_all_cnt = Goodjob.where(task_id: goodjob_params[:task_id]).sum(:number)
    #JavaScriptで画面表示を変更
    respond_to do |format|
      format.js
    end
    
  end

  def index
    #自分とフォロー相手のタスクを表示する
    @feed_tasks = current_user.taskfeed.paginate(:page => params[:page], :per_page => 5)
    #タスクにコメントするためのモデルオブジェクト生成
    @taskline_task_comment = TaskComment.new
    #タスクにグッジョブするためのモデルオブジェクト生成
    @goodjob = Goodjob.new
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
  
  private
    def task_params
      params.require(:task).permit(:title, :content, :user_id, :charge_id, :deadline, :done, :status)
    end
    
    def task_comment_params
      params.require(:comment).permit(:user_id, :task_id, :content)
    end
    
    def goodjob_params
      params.require(:goodjob).permit(:user_id, :task_id, :number)
    end
      
end
