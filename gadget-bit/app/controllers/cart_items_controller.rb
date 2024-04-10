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
    #Even when product not in cart, the default quantity is 1
    if @cart_item.quantity == 1       
      remaining_stock = @selected_product.stock.quantity
    else 
      remaining_stock = @selected_product.stock.quantity - @cart_item.quantity
    end 
  
    if remaining_stock >= requested_quantity
      @cart_item.quantity += requested_quantity
      @cart_item.save 
      redirect_to product_path(@selected_product), notice: 'Product added to cart successfully.'
    else 
      redirect_to product_path(@selected_product), alert: 'Insufficient stock. Unable to add product to cart.'
    end
  end
  
  def remove_from_cart 
    @selected_product = Product.find(params[:product_id])
    @cart_item = @current_cart.cart_items.find_by(product_id: @selected_product)
    @cart_item.destroy 
    if @current_cart.cart_items.empty? 
      redirect_to carts_path(@current_cart)
    else 
      respond_to do |format|
        format.turbo_stream { render turbo_stream: [
          turbo_stream.remove("cart_item_#{@cart_item.id}"), 
          turbo_stream.update("cart_#{@current_cart.id}", partial: 'carts/cart_total_price', locals: { cart: @current_cart }), 
          turbo_stream.update("cart_icon_#{@current_cart.id}",partial: "layouts/total_cart_items_in_cart", locals: { cart: @current_cart })
        ]}
      end
    end
  end

  def add_quantity
    @cart_item = find_cart_item(params[:product_id])
    if @cart_item.product.stock.quantity > @cart_item.quantity
      @cart_item.quantity += 1
      @cart_item.save
      # redirect_to carts_path(@current_cart), notice: 'Quantity incremented successfully.'      
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: render_streams('Quantity incremented successfully.')}
      end
    else
      # redirect_to carts_path(@current_cart), alert: 'Cannot increment quantity further. Product stock limit reached.'
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "carts/flash_messages", locals: { alert: 'Cannot increment quantity further. Product stock limit reached.', alert_type: 'danger' }) }
      end
    end
  end 

  def sub_quantity 
    @cart_item = find_cart_item(params[:product_id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
      # redirect_to carts_path(@current_cart), notice: 'Quantity decremented successfully.'
      respond_to do |format| 
        format.turbo_stream { render turbo_stream: render_streams('Quantity decremented successfully.')}
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

  def find_cart_item(product_id)
    @selected_product = Product.find(params[:product_id])
    @current_cart.cart_items.find_by(product_id: @selected_product)
  end

  def render_streams(message)
    [
      turbo_stream.replace('flash_messages', partial: 'carts/flash_messages', locals: { alert: message, alert_type: 'success' }),
      turbo_stream.update("quantity_#{@cart_item.id}", partial: 'carts/quantity', locals: { cart_item: @cart_item }),
      turbo_stream.update("cart_#{@current_cart.id}", partial: 'carts/cart_total_price', locals: { cart: @current_cart })
    ]
  end
end
