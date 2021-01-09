class ItemPurchase 
  include ActiveModel::Model
  attr_accessor :token, :portal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase

  
      with_options presence: true do
        validates :token
        validates :portal_code, format { with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly" }
        validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
        validates :city
        validates :address
        validates :phone_number, numericality: { greater_than: 1, less_than: 11, message: "Input only number"}
      end
  def save
    purchase = Purchase.create(:user_id, :item_id, :created_at) #購入者の情報を保存し、parchase変数にいれる
    Address.create(:portal_code, :prefecture_id, :city, :address, :building_name, :phone_number, purchase_id: purchase.id)
  end
end