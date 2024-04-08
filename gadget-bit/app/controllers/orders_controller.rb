class OrdersController < ApplicationController 
   
  def order 
    order = Order.new 
    order.user = current_user
    @current_cart.cart_items.each do |cart_item|
      order.cart_items << cart_item
    end
    order.total = @current_cart.total_price 
    order.fulfilled = false

    if order.save
      session[:cart_id] = nil
      Cart.create(user: current_user)
      redirect_to success_path, notice: 'Your order has been placed successfully.'
    else
      redirect_to root_path, alert: 'Failed to place your order. Please try again.'
    end
  end 

  def success 
  end

  def index 
    @orders = current_user.orders
   end 

  def show 
    @order = Order.find(params[:order_id])
  end 
end
