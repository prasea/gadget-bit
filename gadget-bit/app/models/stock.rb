class Stock < ApplicationRecord
  belongs_to :product, dependent: :destroy
end
