class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_of_single_item
    product.price * quantity
  end
end
