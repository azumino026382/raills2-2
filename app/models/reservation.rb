class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :start_date, presence: { message: "チェックイン日を入力してください"}
  validates :end_date, presence: { message: "チェックアウト日を入力してください"}
  validates :person_num, presence: { message: "人数を入力してください"}
  validates :total_price, :person_num, length: { minimum: 1 ,message: "1以上を入力してください" }
  validate :start_check
  validate :end_check

  def start_check
    if self.start_date.present? && self.end_date < Date.today
      errors.add(:end, "過去の日付は使えません")
    end      
  end

  def end_check
    unless self.start_date < self.end_date 
      errors.add(:end_date, "開始日より前の日付は使えません。") 
    end
  end

end
