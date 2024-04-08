class Admin::OrdersController < AdminController 
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
  
end
