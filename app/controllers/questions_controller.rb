class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]
  before_action :sameuser, only: [:edit, :update, :destroy]
  before_action :authenticate_user! 
  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    @question = current_user.questions.build
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = @question.answers.build
    @answers = @question.answers
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.json { render :index, status: :created, location: @question }
        @questions = Question.all
        format.js {render :index, notice: 'Question was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
      @questions = Question.all
      format.js {render :index, notice: 'Question was successfully destroyed.' }
    end
  end
  
  def render_404
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :course, :category, :content, :user_id)
    end
    
    def sameuser
      @question = Question.find(params[:id])
      
      if current_user.id != @question.user_id
        redirect_to root_path
      end
    end

end