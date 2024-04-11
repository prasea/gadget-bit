class Admin::StocksController < AdminController
  before_action :find_product
  
  def new
    redirect_to admin_product_path(@product), notice: 'Stock already exists for product.' if @product.stock.present? 
    @stock = Stock.new(product: @product) unless @product.stock.present? 
  end
  
  def create
    @stock = Stock.new(stock_params)
    @stock.product = @product

    redirect_to edit_admin_product_path(@product), notice: 'Stock added successfully.' if @stock.save      
    render :new unless @stock.save      
  end

  def edit
    @stock = @product.stock
  end

  def update
    @stock = @product.stock
    redirect_to edit_admin_product_path(@product), notice: 'Stock updated successfully.' if @stock.update(stock_params)
    render :edit unless @stock.update(stock_params)
  end
  

  private

  def stock_params
    params.require(:stock).permit(:quantity)
  end
  
  def find_product
    @product = Product.find(params[:product_id])
  end
end
