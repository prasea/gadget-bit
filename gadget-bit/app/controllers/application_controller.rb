class ApplicationController < ActionController::Base
  before_action :set_current_cart
  helper_method :admin_user?, :categories_for_nav

  def set_current_cart
    if current_user && current_user.cart.nil? 
      cart = Cart.create 
      session[:cart_id] = cart.id
      cart.update!(user: current_user)
      @current_cart = cart
    elsif current_user && current_user.cart.present? 
      cart = Cart.where(user_id: current_user.id).last 
      session[:cart_id] = cart.id
      @current_cart = cart
    end 
  end

  def admin_user?
    current_user.is_a?(Admin) if current_user
  end

  def categories_for_nav
    @categories_for_nav ||= Category.all
  end

  protected
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path
    else
      root_path
    end
  end

  private
  def authenticate_admin!
    unless current_user.is_a?(Admin)
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end


end
