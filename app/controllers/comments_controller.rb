class CommentsController < ApplicationController
  before_filter :find_comment, except: [:index, :create]

  def index
    @comments = Article.find(params[:id]).comments
  end

  def create
    @comment = Comment.new(new_comment_params)
    if @comment.save
      redirect_to article_path(@comment.article_id), notice: "Comment posted"
    else
      redirect_to article_path(@comment.article_id), notice: "Comment fail"
    end
  end

  def update
    @comment.update(comment_params)
    if @comment.save
      redirect_to article_path(@comment.article_id), notice: "Comment edited"
    else
      render :edit
    end
  end

  def destroy
    article_id = @comment.article_id
    @comment.destroy
    redirect_to article_path(article_id), notice: "Comment deleted"
  end

  private
    def new_comment_params
      hash = params.require(:comment).permit(:content)
      hash[:article_id] = params[:id]
      hash[:user_id] = current_user.id
      hash
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
end
