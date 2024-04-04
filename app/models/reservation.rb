class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :number_of_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validate :check_in_date_cannot_be_in_the_past, :check_out_date_must_be_after_check_in_date

  # 予約の合計価格を計算
  def total_price
    stay_days = (check_out - check_in).to_i
    room.price * stay_days
  end

  private

  def check_in_date_cannot_be_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は今日以降の日付でなければなりません")
    end
  end

  def check_out_date_must_be_after_check_in_date
    if check_out.present? && check_in.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付でなければなりません")
    end
  end
end
