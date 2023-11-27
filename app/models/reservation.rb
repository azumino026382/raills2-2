class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, presence: true
  validates :total_price, :person_num, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, message: "は1以上を入力してください"} 
  
  validate :start_check,
    :start_end_check
  

  def start_check
    errors.add(:end, "は使えません") if self.start_date.present? && self.end_date < Date.today
  end

  def start_end_check
    errors.add(:end_date, "は開始日より前の日付は使えません。") if self.end_date < self.start_date
  end
end
