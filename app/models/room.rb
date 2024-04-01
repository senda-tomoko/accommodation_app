class Room < ApplicationRecord
# 料金は1円以上でなければならない
  validates :price, numericality: { greater_than_or_equal_to: 1 }

# 他のバリデーションや関連付けもここに追加
  has_one_attached :image
end
