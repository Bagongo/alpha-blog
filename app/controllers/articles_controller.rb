class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
    @articles.each  { |a| a.last_editor = User.find(a.last_editor_id) if User.exists?(a.last_editor_id) }
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.last_editor_id = current_user.id
    
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    @article.last_editor_id = current_user.id
    @article.last_editor_name = current_user.username

    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def show
    @article.last_editor = User.find(@article.last_editor_id) if User.exists?(@article.last_editor_id)
  end

  def destroy
    @article.destroy 
    flash[:success] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private 
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin? 
        flash[:danger] = "You can edit/delete only your own articles"
        redirect_to root_path
      end
    end

end
