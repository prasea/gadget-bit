class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  def index 
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @quick_stats = {
      sales: Order.where(created_at: Time.now.midnight..Time.now).count, 
      revenue: Order.where(created_at: Time.now.midnight..Time.now).sum(:total).try(:round), 
      avg_sale: Order.where(created_at: Time.now.midnight..Time.now).average(:total).try(:round), 
      total_products_sold: Order.joins(:cart_items).where(created_at: Time.now.midnight..Time.now).sum('cart_items.quantity')
    } 
  end

end 
