class Admin::StocksController < ApplicationController
  before_action :find_product
  
  def new
    redirect_to admin_product_path(@product), notice: 'Stock already exists for product.' if @product.stock.present? 
    @stock = Stock.new(product: @product)
      
    # if @product.stock.present?
    #   redirect_to admin_product_path(@product), notice: 'Stock already exists for product.'
    # else
    #   @stock = Stock.new(product: @product)
    # end
  end
  
  def create
    @stock = Stock.new(stock_params)
    @stock.product = @product

    if @stock.save
      redirect_to edit_admin_product_path(@product), notice: 'Stock added successfully.'
    else
      render :new
    end
  end

  def edit
    @stock = @product.stock
  end

  def update
    @stock = @product.stock
    if @stock.update(stock_params)
      redirect_to edit_admin_product_path(@product), notice: 'Stock updated successfully.'
    else
      render :edit
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:quantity)
  end
  
  def find_product
    @product = Product.find(params[:product_id])
  end
end
