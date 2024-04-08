class Room < ApplicationRecord
# 料金は1円以上でなければならない
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  has_one_attached :image
  has_many :reservations
  belongs_to :user
end
