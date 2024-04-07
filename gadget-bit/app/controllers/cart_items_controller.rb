class CartItemsController < ApplicationController
  before_action :authenticate_user!, only: :add_to_cart

  def buy_now 
    find_or_create_cart_item
    @cart_item.save
    redirect_to carts_path(@current_cart)
  end

  def add_to_cart
    find_or_create_cart_item
    requested_quantity = params[:quantity].to_i
    remaining_stock = @selected_product.stock.quantity - @cart_item.quantity
    if remaining_stock >= requested_quantity
      if @cart_item.quantity == 1 
        @cart_item.quantity += requested_quantity-1
      else 
        @cart_item.quantity += requested_quantity
      end
      @cart_item.save 
      redirect_to product_path(@selected_product)
    else 
      redirect_to product_path(@selected_product), notice: 'Insufficient stock. Unable to add product to cart.'
    end
  end

  def remove_from_cart 
    @selected_product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    @cart_item.destroy 
    redirect_to carts_path(@current_cart)	
  end

  def add_quantity
    @selected_product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    if @cart_item.product.stock.quantity > @cart_item.quantity
      @cart_item.quantity += 1
      @cart_item.save
      # redirect_to carts_path(@current_cart), notice: 'Quantity incremented successfully.'      
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace("flash_messages", partial: "carts/flash_messages", locals: { alert: 'Quantity incremented successfully.', alert_type: 'success' }), 
          turbo_stream.update("quantity_#{@cart_item.id}", partial: "carts/quantity", locals: {cart_item: @cart_item}),
          turbo_stream.update( "cart_#{@current_cart.id}", partial: "carts/cart_total_price", locals: { cart: @current_cart } )
        ]}
      end
    else
      # redirect_to carts_path(@current_cart), alert: 'Cannot increment quantity further. Product stock limit reached.'
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "carts/flash_messages", locals: { alert: 'Cannot increment quantity further. Product stock limit reached.', alert_type: 'danger' }) }
      end
    end
  end 

  def sub_quantity 
    @selected_product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
      # redirect_to carts_path(@current_cart), notice: 'Quantity decremented successfully.'
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace("flash_messages", partial: "carts/flash_messages", locals: { alert: 'Quantity decremented successfully.', alert_type: 'success' }), 
          turbo_stream.update("quantity_#{@cart_item.id}", partial: "carts/quantity", locals: {cart_item: @cart_item}),
          turbo_stream.update( "cart_#{@current_cart.id}", partial: "carts/cart_total_price", locals: { cart: @current_cart } )
        ]}
      end
    else
      # redirect_to carts_path(@current_cart), alert: 'Cannot decrement quantity further. Minimum quantity reached.'
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "carts/flash_messages", locals: { alert: 'Cannot decrement quantity further. Minimum quantity reached.', alert_type: 'danger' }) }
      end
    end
  end 
  
  private 
  def find_or_create_cart_item 
    @selected_product = Product.find(params[:product_id])
    if @current_cart.products.include?(@selected_product)
      @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    else 
      @cart_item = CartItem.new 
      @cart_item.cart = @current_cart
      @cart_item.product = @selected_product
    end
  end
end
