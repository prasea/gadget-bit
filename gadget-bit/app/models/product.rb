class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant(:thumb, resize: "50x50")
   end
  belongs_to :category
end
