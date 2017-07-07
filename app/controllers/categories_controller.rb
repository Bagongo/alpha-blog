class CategoriesController < ApplicationController

  before_action :set_category, except: [:index, :new, :create]
  before_action :require_admin, except: [:index, :show] 

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new()
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "The new category was successfully created"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category was successfully updated!"
      redirect_to category_path(@category.id)
    else
      render :edit
    end
  end

  def destroy    
    @category.destroy 
    flash[:success] = "Category was successfully deleted!"
    redirect_to categories_path
  end

  private
  def category_params
      params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:danger] = "You need to be an admin to perform that action!"
      redirect_to categories_path
    end
  end
  
end