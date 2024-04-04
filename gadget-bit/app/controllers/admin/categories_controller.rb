class Admin::CategoriesController < AdminController
  def index 
    @categories = Category.all
  end

  def show 
    @category = Category.find(params[:id])
  end

  def new 
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save 
      redirect_to admin_category_path(@category), notice: 'Category successfully created.'
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
    @category = Category.find(params[:id])
  end

  def update 
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Category successfully updated'
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @category = Category.find(params[:id])
    @category.destroy!
    redirect_to admin_categories_path, status: :see_other
  end
  
  private 
  def category_params
    params.require(:category).permit(:name, :description)
  end
end 
