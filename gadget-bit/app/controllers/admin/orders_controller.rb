class Admin::OrdersController < AdminController 
  before_action :set_order, only: [:mark_fulfilled, :mark_unfulfilled]
  def index 
    # @orders = Order.all
    @not_fulfilled_orders = Order.where(fulfilled: false).order(created_at: :asc)
    @fulfilled_orders = Order.where(fulfilled: true).order(created_at: :asc)
  end

  def show 
    @order = Order.find(params[:id])        
  end

  def mark_fulfilled
    @order = Order.find(params[:id])
    
    @order.cart_items.each do |cart_item|
      product = cart_item.product
      if cart_item.quantity > product.stock.quantity
        redirect_to admin_order_path(@order), alert: "Failed to mark order as fulfilled. Insufficient stock"
        return
      end
    end
    
    Order.transaction do
      @order.cart_items.each do |cart_item|
        product = cart_item.product
        product.stock.update(quantity: product.stock.quantity - cart_item.quantity)
      end
      
      if @order.update(fulfilled: true)
        redirect_to admin_order_path(@order), notice: 'Order marked as fulfilled successfully.'
      else
        redirect_to admin_order_path(@order), alert: 'Failed to mark order as fulfilled.'
      end
    rescue StandardError => e
      redirect_to admin_order_path(@order), alert: "An error occurred: #{e.message}"
    end
  end

  def mark_unfulfilled
    @order = Order.find(params[:id])
  
    if @order.cart_items.empty?
      redirect_to admin_order_path(@order), alert: "Failed to mark order as unfulfilled. No cart items found."
      return
    end
  
    Order.transaction do
      @order.cart_items.each do |cart_item|
        product = cart_item.product
        product.stock.update(quantity: product.stock.quantity + cart_item.quantity)
      end
  
      if @order.update(fulfilled: false)
        redirect_to admin_order_path(@order), notice: 'Order marked as unfulfilled successfully.'
      else
        redirect_to admin_order_path(@order), alert: 'Failed to mark order as unfulfilled.'
      end
    end
  rescue StandardError => e
    redirect_to admin_order_path(@order), alert: "An error occurred: #{e.message}"
  end
  
end


