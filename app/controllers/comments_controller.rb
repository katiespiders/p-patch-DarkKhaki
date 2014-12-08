class CommentsController < ApplicationController
  before_filter :find_comment, only: [:show, :edit]

  def index
    @comments = Article.find(params[:id]).comments
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to article_path(params[:id]), notice: "Comment posted"
    else
      redirect_to article_path(params[:id]), notice: "Comment fail"
    end
  end

  private
    def comment_params
      hash = params.require(:comment).permit(:content)
      hash[:article_id] = params[:id]
      hash[:user_id] = current_user.id
      hash
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
end
