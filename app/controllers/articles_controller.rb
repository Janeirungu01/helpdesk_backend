class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    articles = Article.all.order(created_at: :desc)
    render json: articles
  end

  # GET /articles/:id
  def show
    render json: @article
  end

  # POST /articles
  def create
    article = Article.new(article_params)

    if article.save
      render json: article, status: :created
    else
      render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
    render json: { error: 'Article not found' }, status: :not_found unless @article
  end

  def article_params
    params.require(:article).permit(:question, :answer, :category, tags: [])
  end
end
