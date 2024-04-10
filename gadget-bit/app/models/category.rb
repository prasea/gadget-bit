class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 80 }, uniqueness: true
  validates :description, presence: true, length: {maximum: 500}
  has_many :products, dependent: :destroy
end
