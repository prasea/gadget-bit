class ProductsController < ApplicationController
  def index 
    @products = Product.all
  end

  def show 
    @product = Product.find(params[:id])
    @buy_now_path = current_user ? cart_item_buy_now_path(@product) : new_user_session_path
    @buy_now_method = current_user ? :post : :get
  end
end 
