class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant(:thumb, resize: "50x50")
    attachable.variant :medium, resize_to_limit: [250, 250]
   end
  belongs_to :category
  has_one :stock
end
