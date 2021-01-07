require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品機能' do
      context '商品出品が出来る時' do
        it 'item_name, info, price, category_id, item_status_id, shipping_charge_id, prefecture_id, shipping_date_idが入力されていれば出品できる' do
          expect(@item).to be_valid
        end
      end

      context '商品出品が出来ない時' do
        it 'imageが空であれば出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it 'item_nameが空だと出品できない' do
          @item.item_name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Item name can't be blank")
        end

        it 'infoが空だと出品できない' do
          @item.info = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Info can't be blank")
        end

        it 'category_idが1だと出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category Select')
        end

        it 'item_status_idが1だと出品することができない' do
          @item.item_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Item status Select')
        end

        it 'shipping_charge_idが1だと出品できない' do
          @item.shipping_charge_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Shipping charge Select')
        end

        it 'prefecture_idが1だと出品できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture Select')
        end

        it 'shipping_date_idが1だと出品できない' do
          @item.shipping_date_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Shipping date Select')
        end

        it 'priceが空だと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank", 'Price Half-width number')
        end

        it 'priceが299以下だと出品できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range')
        end

        it 'priceが10,000,000以上だと出品できない' do
          @item.price = 100_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range')
        end

        it 'priceが全角数字だと出品できない' do
          @item.price = '１００００'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Half-width number')
        end

        it 'priceが全角漢字、カナ、かなだと出品できない' do
          @item.price = 'あああああ'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Half-width number')
        end

        it 'priceが半角英数字混合では出品できない' do
          @item.price = 'aaa111'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range', 'Price Half-width number')
        end

        it 'priceが半角英語だけでは出品できない' do
          @item.price = 'aaaaaa'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range', 'Price Half-width number')
        end
      end
    end
  end
end
