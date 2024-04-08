class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  def index 
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @quick_stats = {
      sales: Order.where(created_at: Time.now.midnight..Time.now).count, 
      revenue: Order.where(created_at: Time.now.midnight..Time.now).sum(:total).round(), 
      avg_sale: Order.where(created_at: Time.now.midnight..Time.now).average(:total).round(), 
      total_products_sold: Order.joins(:cart_items).where(created_at: Time.zone.now.all_day).sum('cart_items.quantity')
    } 
  end

end 
