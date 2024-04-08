class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_one :order_address, dependent: :destroy

  def total 
    sum = 0 
    cart_items.each do |cart_item|
      sum += cart_item.total_of_single_item
    end
    return sum 
   end
end
