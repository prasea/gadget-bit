class OrdersController < ApplicationController 

  def order
    @order = Order.new(user: current_user, total: @current_cart.total_price, fulfilled: false)
  
    @current_cart.cart_items.each do |cart_item|
      @order.cart_items << cart_item
    end
  
    @order_address = OrderAddress.new(order_address_params)
  
    if @order.save
      @order_address.order_id = @order.id
  
      if @order_address.save
        # OrderMailer.with(user: current_user, order: @order).order_confirmation_email.deliver_now        
        if Rails.env.production?
          SendOrderConfirmationEmailJob.perform_later(current_user.id, @order.id)
          SendNewOrderEmailJob.perform_later(@order.id)
        end

        Cart.create(user: current_user)
        session[:cart_id] = nil
        redirect_to success_path, notice: 'Your order has been placed successfully.'
      else
        @order.destroy  
        redirect_to root_path, alert: 'Failed to place your order address. Please try again.'
      end
    else
      redirect_to root_path, alert: 'Failed to place your order. Please try again.'
    end
  end
    
  def new_order_address
    @order_address = OrderAddress.new
  end

  def success 
  end

  def index 
    @orders = current_user.orders
   end 

  def show 
    @order = Order.find(params[:order_id])
  end 

  def destroy 
    @order = Order.find(params[:order_id])
    @order.destroy 
    redirect_to orders_path, notice: 'Order cancelled successfully'
  end
  private

  def order_address_params
    params.require(:order_address).permit(:city, :state)
  end  
end
