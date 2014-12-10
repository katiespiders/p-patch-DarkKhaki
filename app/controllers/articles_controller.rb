class ArticlesController < ApplicationController
  before_action :find, only: [:show, :update, :destroy]
  before_action :authorize_admin, except: [:index, :show]

  def index
    @articles = Article.all.order("created_at desc")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.update(user_id: current_user.id)
    @article.update(pic: 'placeholder.jpg') unless @article.pic?
    if @article.save
     User.spam(:article)
      redirect_to article_path(@article.id), notice: "Posted #{@article.title}"
    else
      render :new, notice: "Put in some real error messages, Katie"
    end
  end

  def update
    @article.update(article_params)
    if @article.save
      redirect_to article_path(@article.id), notice: "Edited #{@article.title}"
    else
      render :edit, notice: "I said put in real error messages"
    end
  end

  def destroy
    title = @article.title
    @article.destroy
    redirect_to articles_path, notice: "Deleted #{title}"
  end
  #
  # def auth_error
  #   unless authorized?
  #     notice = "This needs a real error"
  #     redirect = @article ? article_path(@article.id) : articles_path
  #     redirect_to redirect, notice
  #   end
  # end

  private
    def article_params
      params.require(:article).permit(:title, :content, :pic, :user_id)
    end

    def find
      @article = Article.find_by(id: params[:id])
    end

    def pic?
      @article.pic
      # how to have this also return whether or not link is actually to a picture?
    end


end
