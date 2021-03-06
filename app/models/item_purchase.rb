class ItemPurchase 
  include ActiveModel::Model
  attr_accessor :token, :portal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id, :user_id, :item_id 
    with_options presence: true do
        validates :token
        validates :portal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly" }
        validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
        validates :city
        validates :address
        validates :phone_number, format: { with: /\A\d{10,11}\z/ , message: "Input only number"}
    end
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(portal_code: portal_code, prefecture_id: prefecture_id, city: city, 
      address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end