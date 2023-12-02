class Room < ApplicationRecord
    validates :room_name, presence: { message: "施設の名前を入力してください"}
    validates :content, presence: { message: "施設の詳細を入力してください"}
    validates :address, presence: { message: "施設の住所を入力してください"}
    validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, message: "施設の料金(1円以上)を入力してください"}
    
    has_many :reservations

    mount_uploader :room_image, RoomUploader

    def self.search_area(search)
      if search
        Room.where(['address like?', "%#{search}%"])
      else
        Room.none
      end  
    end

    def self.search_free(search)
      if search
        Room.where(['room_name like? OR content like?', "%#{search}%", "%#{search}%"])
      else
        Room.none      
      end
    end              
      
end
