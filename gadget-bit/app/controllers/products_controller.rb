class ProductsController < ApplicationController
  
  def index 
    @pagy, @products = pagy(Product.includes(:category).joins(:stock).where("stocks.quantity > 0").order(created_at: :desc))
    @buy_now_method = current_user ? :post : :get

    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])     
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])     
    end
  end

  def show 
    @product = Product.find(params[:id])
    @buy_now_path = current_user ? buy_now_path(@product) : new_user_session_path
    @buy_now_method = current_user ? :post : :get
  end

  def search
    if params[:q].present?
      @products = Product.includes(:category).joins(:stock).where("products.name ILIKE ?", "%" + params[:q] + "%").where("stocks.quantity > 0").order(created_at: :desc)
      if @products.empty?
        flash.now[:notice] = "No products found for '#{params[:q]}'."
      end
    else
      flash[:notice] = "Please enter a search query."
      redirect_to products_path
    end
  end
  
end 
