class OrdersController < ApplicationController 

  def order
    @order = Order.new(user: current_user, total: @current_cart.total_price, fulfilled: false)
    @order_address = OrderAddress.new(order_address_params)
  
    if @order.save
      @current_cart.cart_items.each do |cart_item|
        @order.order_products.create(product_id: cart_item.product_id, quantity: cart_item.quantity)
      end
      @order_address.order_id = @order.id
  
      if @order_address.save
        # OrderMailer.with(user: current_user, order: @order).order_confirmation_email.deliver_now        
        # OrderMailer.with(order: @order).new_order_email.deliver_now
        # Using ActiveJob For Sending Mail !
        # SendOrderConfirmationEmailJob.perform_now(current_user.id, @order.id)
        # SendNewOrderEmailJob.perform_now(@order.id)
        @current_cart.cart_items.destroy_all
        session[:cart_id] = nil
        redirect_to success_path, notice: 'Your order has been placed successfully.'
      else
        flash.now[:alert] = @order_address.errors.full_messages.join(', ')
        render :new_order_address, status: :unprocessable_entity
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
    params.require(:order_address).permit(:city, :state, :area, :landmark)
  end  
end
