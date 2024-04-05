
class Admin::StocksController < ApplicationController
  before_action :find_product

  def new
    # Check if stock already exists for the product
    if @product.stock
      redirect_to admin_product_path(@product), alert: 'Stock already exists for this product.'
    else
      @stock = @product.build_stock
    end
  end

  def create
    # Check if stock already exists for the product
    if @product.stock
      redirect_to admin_product_path(@product), alert: 'Stock already exists for this product.'
    else
      @stock = @product.build_stock(stock_params)
      if @stock.save
        redirect_to admin_product_path(@product), notice: 'Stock added successfully.'
      else
        render :new
      end
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def stock_params
    params.require(:stock).permit(:quantity, :location, :expiration_date, :purchase_price)
  end
end
