class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  with_options presence: true do
    validates :image
    validates :item_name
    validates :info
    validates :price, numericality: { only_integer:true, greater_than: 300, less_then: 9999999, message: "Half-width number" }
  end

    with_options presence: true, numericality:  {other_than: 1, message: "Select"} do
      validates :category_id
      validates :item_status_id
      validates :shipping_charge_id
      validates :prefecture_id
      validates :shipping_date_id
    end

  belongs_to :category
  belongs_to :item_status
  belongs_to :prefecture
  belongs_to :shipping_charge
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image
end
