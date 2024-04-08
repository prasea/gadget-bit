class OrderAddress < ApplicationRecord
  belongs_to :order
  NEPAL_STATES = ['Koshi Province', 'Madhesh Province', 'Bagmati Province', 'Gandaki Province', 'Lumbini Province', 'Karnali Province', 'Sudurpashchim Province']
end
