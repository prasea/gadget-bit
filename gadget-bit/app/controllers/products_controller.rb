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

  def search
    if params[:q].present?
      @products = Product.where("name ILIKE ?", "%" + params[:q] + "%")
    else
      flash[:notice] = "Please enter a search query."
      redirect_to products_path
    end
  end
end 
