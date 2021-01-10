class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nick_name
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: ' Full-width characters' } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A[ァ-ヶ一]+\z/, message: 'Full-width katakana characters' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birth_id
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'both letters and numbers' }
  has_many :items
  has_many :purchases
end
