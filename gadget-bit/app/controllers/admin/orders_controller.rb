class Admin::OrdersController < AdminController 
  def index 
    # @orders = Order.all
    @not_fulfilled_orders = Order.where(fulfilled: false).order(created_at: :asc)
    @fulfilled_orders = Order.where(fulfilled: true).order(created_at: :asc)
  end

  def show 
    @order = Order.find(params[:id])        
  end
end
