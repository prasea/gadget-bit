class OrderAddress < ApplicationRecord
  validates :city, presence: true, length: { maximum: 25 }
  validates :area, presence: true, length: { maximum: 25 }
  validates :state, presence: true, format: { with: /\A(Koshi|Madhesh|Bagmati|Gandaki|Lumbini|Karnali|Sudurpashchim)\z/, message: "must be a valid state" }

  belongs_to :order
  NEPAL_STATES = ['Koshi', 'Madhesh', 'Bagmati', 'Gandaki', 'Lumbini', 'Karnali', 'Sudurpashchim']
  # enum state: { 'Koshi': 0, 'Madhesh': 1, 'Bagmati': 2, 'Gandaki': 3, 'Lumbini': 4, 'Karnali': 5, 'Sudurpashchim': 6 }
end
