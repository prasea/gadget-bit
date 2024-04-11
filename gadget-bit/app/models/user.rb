class User < ApplicationRecord
  validates :name, presence: true
  validates :contact, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy 
end
