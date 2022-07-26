require 'rails_helper'

RSpec.describe OrderBuyer, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_buyer = FactoryBot.build(:order_buyer, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end
  describe '配送先情報の登録' do
    context '配送先情報が登録できるとき' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@order_buyer).to be_valid
      end
      it 'user_idが空でなければ登録できる' do
        @order_buyer.user_id = 1
        expect(@order_buyer).to be_valid
      end
      it 'item_idが空でなければ登録できる' do
        @order_buyer.item_id = 1
        expect(@order_buyer).to be_valid
      end
      it '郵便番号が3桁と「-」ハイフンと4桁の組み合わせであれば登録できる' do
        @order_buyer.postal_code = '123-4567'
        expect(@order_buyer).to be_valid
      end
      it '都道府県が「---」以外であれば登録できる' do
        @order_buyer.prefecture = 1
        expect(@order_buyer).to be_valid
      end 
      it '市区町村が空でなければ登録できる' do
        @order_buyer.city = "横浜市緑区"
        expect(@order_buyer).to be_valid
      end
      it '番地が空でなければ登録できる' do
        @order_buyer.block = "青山1-1-1"
        expect(@order_buyer).to be_valid
      end
      it '建物名が空でも登録できる' do
        @order_buyer.building_name = nil
        expect(@order_buyer).to be_valid
      end
      it '電話番号が11桁以内でかつ「-」ハイフンなしであれば登録できる' do
        @order_buyer.phone_number = '09012345678'
        expect(@order_buyer).to be_valid
      end
    end

    context '配送先の情報が登録できないとき' do
      it 'user_idが空だと登録できない' do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと登録できない' do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Item can't be blank")
      end
      it '都道府県が「---」だと登録できない' do
        @order_buyer.prefecture = 0
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '郵便番号が空だと保存できない' do
        @order_buyer.postal_code = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が「-」ハイフンなしだと登録できない' do
        @order_buyer.postal_code = '1234567'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '市区町村が空だと登録できない' do
        @order_buyer.city = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと登録できない' do
        @order_buyer.block = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空だと登録できない' do
        @order_buyer.phone_number = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号に「-」ハイフンがあると登録できない' do
        @order_buyer.phone_number = '090 - 123 - 4567'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number invalid. Input only number")
      end
      it '電話番号が9桁以下だと登録できない' do
        @order_buyer.phone_number = '090123456'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone number invalid. Input only number")
      end
      it 'トークンが空だと登録できない' do
        @order_buyer.token = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
