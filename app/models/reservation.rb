class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :number_of_people, presence: true
  validate :check_in_after_today, :check_out_after_check_in
  validates :number_of_people, numericality: { greater_than: 0 }

  # 予約の合計価格を計算
  def total_price
    nights = (check_out - check_in).to_i
    nights * room.price * number_of_people
  end
end

  private


  def check_in_after_today
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は今日以降の日付でなければなりません")
    end
  end


  def check_out_after_check_in
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付でなければなりません。")
    end
  end
