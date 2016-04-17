class CommentsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

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
    @article  = Article.find(params[:article_id])
    @comment  = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), notice: "Comment deleted!"
  end

  private

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
