class Admin < User 
  validates :contact, presence: false
end
