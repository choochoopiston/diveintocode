class AnswersController < ApplicationController
  before_action :set_answer, only: [:show]
  before_action :sameuser, only: [:edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
  end

  # GET /answers/1/edit
  def edit
    @question = Question.find(params[:question_id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

    respond_to do |format|
      if @answer.save
        @question = @answer.question
        AnswerMailer.answer_email(@answer, @question).deliver
        format.html { redirect_to question_path(@answer.question_id), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
        @question = @answer.question
        format.js { render :index, notice: 'Answer was successfully created.' }
      else
        format.html { redirect_to question_path(@answer.question_id) }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@answer.question_id), notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
      @question = @answer.question
      format.js { render :index, notice: 'Answer was successfully destroyed.' }
    end
  end

  def render_404
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end

    def sameuser
      @answer = Answer.find(params[:id])
      
      if current_user.id != @answer.user_id
        redirect_to root_path
      end
    end
    
end
