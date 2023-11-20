class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :email, :password, :password_confirmation, presence: { message: "省略できません" }, on: :create
  
  has_many :reservations, dependent: :destroy

  mount_uploader :user_image, ImageUploader
         
end
