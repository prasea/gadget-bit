class Order < ApplicationRecord
  belongs_to :user
 
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  has_many :cart_items, dependent: :destroy
  has_one :order_address, dependent: :destroy

  def total 
    sum = 0 
    order_products.each do |cart_item|
      sum += cart_item.total_of_single_item
    end
    return sum 
   end
end
