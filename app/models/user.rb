class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable
  validates :nick_name, presence: true
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message:' Full-width characters'} 
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message:' Full-width characters'} 
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: ' Full-width katakana characters'} 
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: ' Full-width katakana characters'} 
  validates :birth_id, presence: true
  validates :password, format: {with: (/[a-z\d]{6,}/i), message: 'both letters and numbers'}
end
