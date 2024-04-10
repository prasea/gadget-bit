class Cart < ApplicationRecord
  belongs_to :user, dependent: :destroy
  # validates :user_id, uniqueness: true 
  has_many :cart_items, dependent: :destroy 
  has_many :products, through: :cart_items, dependent: :destroy

  def total_price 
    sum = 0 
    cart_items.each do |cart_item|
      sum += cart_item.total_of_single_item
    end
    return sum 
   end
end
