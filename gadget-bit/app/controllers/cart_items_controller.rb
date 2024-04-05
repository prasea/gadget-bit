class CartItemsController < ApplicationController
  before_action :authenticate_user!, only: :add_to_cart
  def buy_now 
    find_or_create_cart_item
    @cart_item.save
    redirect_to carts_path(@current_cart)
  end

  def add_to_cart
    find_or_create_cart_item
    requested_quantity = params[:quantity].to_i
    remaining_stock = @selected_product.stock.quantity - @cart_item.quantity
    if remaining_stock >= requested_quantity
      if @cart_item.quantity == 1 
        @cart_item.quantity += requested_quantity-1
      else 
        @cart_item.quantity += requested_quantity
      end
      @cart_item.save 
      redirect_to product_path(@selected_product)
    else 
      redirect_to product_path(@selected_product), notice: 'Insufficient stock. Unable to add product to cart.'
    end
  end


  def remove_from_cart 
    @selected_product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    @cart_item.destroy 
    redirect_to carts_path(@current_cart)	
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
    end
  end
end
