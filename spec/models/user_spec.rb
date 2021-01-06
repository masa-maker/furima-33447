require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it "nick_name, email, password,password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birth_idが入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it "nick_nameが空では登録できない" do
        @user.nick_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick name can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailが重複していれば登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "emailは@含まれていなければ登録できない" do
        @user.email = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "password６文字以上でなければ登録できない" do
        @user.password = "ashe1"
        @user.password_confirmation = "ashe1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordは英語のみでは登録できない" do
        @user.password = "aaaa"
        @user.password_confirmation = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password both letters and numbers")
      end

      it "passwordは数字のみでは登録できない" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password both letters and numbers")
      end

      it "passwordは全角では登録できない" do
        @user.password = "パスワードです"
        @user.password_confirmation = "パスワードです"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password both letters and numbers")
      end

      it "passwordとpassword_confirmationが一致していなければ登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") 
      end

      it "last_nameが入力されていなければ登録することができない" do
        @user.last_name =""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name  Full-width characters")
      end

      it "last_nameは漢字、平仮名、カタカナ以外では登録することができない" do
        @user.last_name ="namae"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name  Full-width characters")
      end

      it "first_nameが入力されていなければ登録することができない" do
        @user.first_name =""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name  Full-width characters")
      end

      it "first_nameは、漢字、平仮名、カタカナでなければ登録することができない" do
        @user.first_name ="namae"
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name  Full-width characters")
      end

      it "last_name_kanaが入力されていなければ登録することができない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana Full-width katakana characters")
      end

      it "last_name_kanaは、全角カタカナ以外では登録することができない" do
        @user.last_name_kana = "あw阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end

      it "first_name_kanaが入力されていなければ登録することができない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank",
          "First name kana Full-width katakana characters")
      end

      it "first_name_kanaは、全角カタカナ以外では登録することができない" do
        @user.first_name_kana = "あw阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end

      it "birth_idが選択されていなければ登録することができない" do
        @user.birth_id = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
