class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant(:thumb, resize: "50x50")
    attachable.variant :medium, resize_to_limit: [250, 250]
   end
  belongs_to :category

  has_many :order_products
  has_many :orders, through: :order_products

  has_many :cart_items, dependent: :destroy 
  has_one :stock, dependent: :destroy
  before_create :build_default_stock

  private
  def build_default_stock
    build_stock(quantity: 1)
  end
end
