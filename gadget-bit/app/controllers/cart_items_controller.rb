class CartItemsController < ApplicationController
  def buy_now 
    find_or_create_cart_item
    redirect_to carts_path(@current_cart)
  end

  def add_to_cart
    find_or_create_cart_item
    if @cart_item.quantity == 1 
      @cart_item.quantity += (params[:quantity].to_i - 1)
    else 
      @cart_item.quantity += (params[:quantity].to_i)
    end
    @cart_item.save 
    redirect_to product_path(@selected_product), notice: 'Product successfully added to cart'
  end

  private 
  def find_or_create_cart_item 
    @selected_product = Product.find(params[:product_id])
    if @current_cart.products.include?(@selected_product)
      @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    else 
      @cart_item = CartItem.new 
      @cart_item.cart = @current_cart
      @cart_item.product = @selected_product
      @cart_item.save 
    end
  end
end
