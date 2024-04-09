class CategoriesController < ApplicationController
  def show 
    @category = Category.find(params[:id])
    @pagy, @products = pagy(@category.products.order(created_at: :desc))
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])     
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])     
    end
  end
end
