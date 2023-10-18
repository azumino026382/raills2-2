class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :start_date, presence: { message: "チェックイン日を入力してください"}
  validates :end_date, presence: { message: "チェックアウト日を入力してください"}
  validates :person_num, presence: { message: "人数を入力してください"}
  validate :start_check

    def start_check
        if self.start_date.present? && self.end_date < Date.today
          errors.add(:end, "過去の日付は使えません")
        end      
    end
       
end
