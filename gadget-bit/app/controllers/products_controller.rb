class ProductsController < ApplicationController
  
  def index 
    @products = Product.all
    @buy_now_method = current_user ? :post : :get
  end

  def show 
    @product = Product.find(params[:id])
    @buy_now_path = current_user ? buy_now_path(@product) : new_user_session_path
    @buy_now_method = current_user ? :post : :get
  end
end 
