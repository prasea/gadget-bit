class Admin::ProductsController < AdminController
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
    @product = Product.find(params[:id])
  end

  private 
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end
end
