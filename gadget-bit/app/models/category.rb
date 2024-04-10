class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: {maximum: 500}
  has_many :products, dependent: :destroy
end
