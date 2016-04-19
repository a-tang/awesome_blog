class ArticlesController < ApplicationController
before_action :authenticate_user!, except: [:index, :show, :about]
before_action :find_article, only: [:edit, :update, :destroy, :show]
before_action :authorize_question, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
      if params[:search]
        @articles = Article.search(params[:search]).order("created_at DESC")
      else
        @articles = Article.all.order('created_at DESC')
      end
  end

  def show
    @article = Article.find(params[:id])
  end

  def about
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :text, :category_id))
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # @article = Article.find(params[:id])
    # article_params = params.require(:article).permit([:title, :text, :category_id])
    if @article.update article_params
      redirect_to @article, notice: "Article updated!"
    else
      render 'edit'
    end
  end


  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Article: #{@article.title} deleted!"
  end

  private

  def authorize_question
    redirect_to root_path unless can? :manage, @article
  end

  def find_article
    @article = Article.find params[:id]
  end

  def article_params
    params.require(:article).permit([:title, :text, :category_id])
  end

end
