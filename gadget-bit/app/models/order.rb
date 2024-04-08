class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_one :order_address, dependent: :destroy
end
