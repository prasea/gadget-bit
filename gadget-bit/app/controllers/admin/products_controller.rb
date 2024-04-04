class Admin::ProductsController < AdminController
  before_action :set_product, only: %i[show edit update destroy]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new 
  end

  def create 
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product successfullly created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show 
  end

  def edit 
  end

  def update 
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product successfully updated'
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @product.destroy!
    redirect_to admin_products_path, status: :see_other
  end

  
  private 
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
