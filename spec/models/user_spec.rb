require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  describe 'validations' do
    it 'should be valid' do
      expect(@user).to be_valid
    end
    it 'name should be present' do
      @user.name = ''
      expect(@user).not_to be_valid
    end

    it 'email should be present' do
      @user.email = ''
      expect(@user).not_to be_valid
    end

    it 'name should not be too short' do
      @user.name = 'a' * 2
      expect(@user).not_to be_valid
    end

    it 'name should not be too long' do
      @user.name = 'a' * 51
      expect(@user).not_to be_valid
    end

    it 'email should not be too long' do
      @user.email = "#{'a' * 244}@example.com"
      expect(@user).not_to be_valid
    end
    it 'email validation should accept valid addresses' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it 'email validation should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end

    it 'password should be present' do
      @user.password = ' ' * 6
      expect(@user).not_to be_valid
    end

    it 'password should have a minimum length' do
      @user.password = 'a' * 5
      expect(@user).not_to be_valid
    end
  end

  describe 'before_save callback' do
    it 'downcase the email before saving' do
      user = create(:user, email: 'USER@EXAMPLE.COM')
      expect(user.email).to eq('user@example.com')
    end
  end
  describe 'has_secure_password' do
    it 'encrypts the password' do
      user = create(:user, password: 'password123')
      expect(user.authenticate('password123')).to be_truthy
      expect(user.authenticate('wrongpassword')).to be_falsey
    end
  end
end
