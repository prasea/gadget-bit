class CartItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 4 }
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product

  def total_of_single_item
    product.price * quantity
  end

  def valid_quantity?(requested_quantity)
    quantity + requested_quantity <= 4
  end
end
