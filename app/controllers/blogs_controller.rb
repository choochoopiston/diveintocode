class BlogsController < ApplicationController
  before_action :set_blog, only: [:show]
  before_action :sameuser, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /blogs
  # GET /blogs.json
  def index
    @users = current_user.each_other_follows
  end

  # GET /blogs/1
  # GET /blogs/1.json
  # showアクションが呼び起こされた際に、画面上に「コメントの入力フォーム」が表示。つまりshowアクション時に"該当ブログにひもづくコメントのモデルオブジェクト"を生成
  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
    
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def render_404
    redirect_to root_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :user_id)
    end
    
    def sameuser
      
      @blog = Blog.find(params[:id])
      
      if current_user.id != @blog.user_id
        redirect_to root_path
      end
    end
    
end
