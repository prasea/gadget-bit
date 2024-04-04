class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product
end
