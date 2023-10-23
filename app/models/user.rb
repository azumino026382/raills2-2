class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  validates :name, :email, :password, :password_confirmation, presence: true

  has_many :reservations, dependent: :destroy
  
  has_one_attached :avatar
end
