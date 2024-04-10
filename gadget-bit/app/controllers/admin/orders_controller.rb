class Admin::OrdersController < AdminController 
  def index 
    # @orders = Order.all
    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(Order.where(fulfilled: false).order(created_at: :asc))
    @fulfilled_pagy, @fulfilled_orders = pagy(Order.where(fulfilled: true).order(created_at: :asc), page_param: :page_fulfilled)
  end

  def show 
    @order = Order.find(params[:id])        
  end

  def mark_fulfilled
    @order = Order.find(params[:id])
    @order.order_products.each do |order_product|
      product = order_product.product
      if order_product.quantity > product.stock.quantity
        redirect_to admin_order_path(@order), alert: "Failed to mark order as fulfilled. Insufficient stock"
      end
    end
    update_order_product_stock(true)
  end

  def mark_unfulfilled
    @order = Order.find(params[:id])
    if @order.order_products.empty?
      redirect_to admin_order_path(@order), alert: "Failed to mark order as unfulfilled. No cart items found."
    end
    update_order_product_stock(false)
  end

  private

  def update_order_product_stock(order_status)
    Order.transaction do
      @order.order_products.each do |cart_item|
        product = cart_item.product
        new_quantity = order_status ? product.stock.quantity - cart_item.quantity : product.stock.quantity + cart_item.quantity
        product.stock.update(quantity: new_quantity)
      end
      if @order.update(fulfilled: order_status)
        redirect_to admin_order_path(@order), notice: "Order marked as #{order_status ? 'fulfilled' : 'unfulfilled'} successfully."
      else
        redirect_to admin_order_path(@order), alert: "Failed to mark order as #{order_status ? 'fulfilled' : 'unfulfilled'}."
      end
    end
  rescue StandardError => e
    redirect_to admin_order_path(@order), alert: "An error occurred: #{e.message}"
  end
end


