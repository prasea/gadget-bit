class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant(:thumb, resize: "50x50")
    attachable.variant :medium, resize_to_limit: [250, 250]
   end
  belongs_to :category, dependent: :destroy
  has_many :cart_items  
  has_one :stock
  before_create :build_default_stock

  private
  def build_default_stock
    build_stock(quantity: 1)
  end
end
