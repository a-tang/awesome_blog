class CommentsController < ApplicationController
before_action :authenticate_user!
before_action :find_article
before_action :find_and_authorize_comment, only: :destroy

  def create
    @article          = Article.find(params[:article_id])
    comment_params    = params.require(:comment).permit(:commenter, :body, :category_id)
    @comment          = Comment.new comment_params
    # @comment        = @article.comments.create(comment_params)
    @comment.article  = @article
    @comment.user     = current_user
    if @comment.save
      redirect_to article_path(@article)
      flash[:notice]  = "Thanks for the comment"
    else
      flash[:alert]   = "Something is wrong"
      render '/articles/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), notice: "Comment deleted!"
  end

  private

  def find_article
    @article = Article.find params[:article_id]
  end

  def find_and_authorize_comment
    @comment = @article.comments.find params[:id]
    redirect_to root_path unless can? :destroy, @comment
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
