require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  describe '#create' do
    before do
      @item_purchase = FactoryBot.build(:item_purchase)
    end

    describe '商品購入機能' do
      context '商品購入ができるとき' do
        it 'token, portal_code, prefecture_id, city, building_name ,address, phone_numberが入力されていたら購入できる' do
          expect(@item_purchase).to be_valid
        end

        it 'building_nameの入力がなくても購入できる' do
          @item_purchase.building_name = ""
          expect(@item_purchase).to be_valid
        end

        it '電話番号は10桁でも購入できる' do
          @item_purchase.phone_number = 1234567890
          expect(@item_purchase).to be_valid
        end
      end

      context '商品購入ができないとき' do
        it 'tokenが空であれば購入できない' do
          @item_purchase.token = ""
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Token can't be blank")
        end

        it 'portal_codeが空では購入できない' do
          @item_purchase.portal_code = ""
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Portal code can't be blank")
        end

        it 'portal_codeはハイフンがなければ購入することができない（123-1234となる）' do
          @item_purchase.portal_code = "1231234"
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Portal code Input correctly")
        end

        it 'portal_codeはハイフンあっても桁数を間違えていれば購入することができない（1231-1234）' do
          @item_purchase.portal_code = "1234-1234"
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Portal code Input correctly")
        end

        it 'portal_codeはハイフンあっても桁数を間違えていれば購入することができない（123-12345）' do
          @item_purchase.portal_code = "123-12345"
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Portal code Input correctly")
        end

        it 'prefecture_idは1を選択すると購入できない' do
          @item_purchase.prefecture_id = 1
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Prefecture Select")
        end

        it 'cityが空では購入できない' do
          @item_purchase.city = ""
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("City can't be blank")
        end

        it 'addressが空では購入できない' do
          @item_purchase.address = ""
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Address can't be blank")
        end

        it 'phone_numberが空では購入できない' do
          @item_purchase.phone_number = ""
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Phone number can't be blank")
        end

        it 'phone_numberは10桁以上入力でなければ購入できない' do
          @item_purchase.phone_number = 123456789
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Phone number Input only number")
        end

        it 'phone_numberは全角数字では購入できない' do
          @item_purchase.phone_number = "１２３４５６７８９０１"
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Phone number Input only number")
        end

        it 'phone_numberは文字列では購入できない' do
          @item_purchase.phone_number = "ああああああ"
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("Phone number Input only number")
        end
      end
    end
  end
end
