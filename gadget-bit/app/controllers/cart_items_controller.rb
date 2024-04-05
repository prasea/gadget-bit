class CartItemsController < ApplicationController
  def buy_now 
    @selected_product = Product.find(params[:product_id])
    if @current_cart.products.include?(@selected_product)
      @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    else 
      @cart_item = CartItem.new 
      @cart_item.cart = @current_cart
      @cart_item.product = @selected_product
      @cart_item.save 
    end
    redirect_to carts_path(@current_cart)
  end
end
