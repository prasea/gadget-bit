class User < ApplicationRecord
  validates :name, presence: true
  validates :contact, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy 
end
