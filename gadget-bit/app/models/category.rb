class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 80 }, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: "of category can only contain letters" }
  validates :description, presence: true, length: {maximum: 500}
  has_many :products, dependent: :destroy
end
