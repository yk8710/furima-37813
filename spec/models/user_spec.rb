require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it 'すべての入力事項が存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'passwordが6文字以上半角英数字であれば登録できる' do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end
    it 'last_nameが全角(漢字・ひらがな・カタカナ)であれば登録できる' do
      @user.last_name = '山田'
      expect(@user).to be_valid
    end
    it 'first_nameが全角(漢字・ひらがな・カタカナ)であれば登録できる' do
      @user.first_name = '陸太郎'
      expect(@user).to be_valid
    end
    it 'last_name_kanaが全角カタカナであれば登録できる' do
      @user.last_name_kana = 'ヤマダ'
      expect(@user).to be_valid
    end
    it 'first_nameが全角カタカナであれば登録できる' do
      @user.first_name_kana = 'リクタロウ'
      expect(@user).to be_valid
    end
  end

  context '新規登録ができないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'emaiは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'password_confirmationが空では登録できない' do
      @user.password = '123abc'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordが5文字以下だと登録できない' do
      @user.password = '12abc'
      @user.password_confirmation = '12abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが数字のみだと登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid.Include both letters and numbers")
    end
    it 'passwordが英字のみだと登録できない' do
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid.Include both letters and numbers")
    end
    it 'passwordが全角文字だと登録できない' do
      @user.password = 'ABCDEF'
      @user.password_confirmation = 'ABCDEF'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid.Include both letters and numbers")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123abc'
      @user.password_confirmation = '123abcd'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last_nameが全角(漢字、ひらがな、カタカナ)でないと登録できない' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid.Input full-width characters')
    end
    it 'first_nameが全角(漢字、ひらがな、カタカナ)でないと登録できない' do
      @user.first_name = 'rikutarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid.Input full-width characters')
    end
    it 'last_name_kanaが空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'first_name_kanaが空だと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'last_name_kanaが全角カタカナでないと登録できない' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid.Input full-width katakana characters")
    end
    it 'first_name_kanaが全角カタカナでないと登録できない' do
      @user.first_name_kana = 'りくたろう'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid.Input full-width katakana characters")
    end
    it '生年月日が空欄だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end

  



