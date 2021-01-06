class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nick_name
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: ' Full-width characters' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: ' Full-width characters' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶ一]+\z/, message: "Full-width katakana characters" }
    validates :first_name_kana, format: { with: /\A[ァ-ヶ一]+\z/, message: "Full-width katakana characters" }
    validates :birth_id
  end
    validates :password, format: { with: (/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i), message: 'both letters and numbers' }
end
