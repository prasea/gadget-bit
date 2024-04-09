class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product

  def total_of_single_item
    product.price * quantity
  end
end
