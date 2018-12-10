require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      email: 'test@test.com',
      name: 'Tester',
      password: '12356789',
      password_confirmation: '12356789'
    )
  end

  describe 'Validations' do
    it 'is valid with an email, name, password, and password_confirmation' do
      expect(@user).to be_valid
    end

    it 'is not valid without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'is not valid without a name' do
      @user.name = nil
      expect(@user).not_to be_valid
    end

    it 'is not valid without a password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end

    it 'is not valid without a password_confirmation' do
      @newest_user = User.new(
        email: 'test@test.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: nil
      )
      expect(@newest_user).not_to be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      @user.password = '123'
      @user.password_confirmation = '456'
      expect(@user).not_to be_valid
    end

    it 'will not create a model if password and password_confirmation do not match' do
      @new_user = User.new(
        email: 'test@test.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: '1235678910'
      )
      expect(@new_user).not_to be_valid
    end

    it 'should only allow unique emails' do
      @user1 = User.create(
        email: 'test1@test.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: '12356789'
      )
      @user2 = User.create(
        email: 'test1@test.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: '12356789'
      )
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
    end

    it 'should only allow unique emails, even if the case differs (not case sensitive)' do
      @user3 = User.create(
        email: 'test2@test.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: '12356789'
      )
      @user4 = User.create(
        email: 'TEST2@TEST.com',
        name: 'Tester',
        password: '12356789',
        password_confirmation: '12356789'
      )
      expect(@user3).to be_valid
      expect(@user4).not_to be_valid
    end

    it 'should validate the length of password' do
      @user5 = User.create(
        email: 'user5@test.com',
        name: 'Tester',
        password: 'short',
        password_confirmation: 'short'
      )
      @user6 = User.create(
        email: 'user6@test.com',
        name: 'Tester',
        password: 'longlonglong',
        password_confirmation: 'longlonglong'
      )
      expect(@user5).not_to be_valid
      expect(@user6).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'Should return instance of user when credentials are correct' do
      @authenticatedUser = User.create(
        email: 'tester@test.com',
        name: 'Testere',
        password: '1235678910',
        password_confirmation: '1235678910'
      )
      expect(User.authenticate_with_credentials('tester@test.com', '1235678910')).to eq @authenticatedUser
    end

    it 'Should return nill when credentials are not correct' do
      @authenticatedUser2 = User.create(
        email: 'tester2@test.com',
        name: 'Testere',
        password: '123567891011',
        password_confirmation: '123567891011'
      )
      expect(User.authenticate_with_credentials('tester2@test.com', '1235678910')).to be_nil
    end

    it 'Should return instance of user when credentials are correct and a visitor types in a few spaces before their email address' do
      @authenticatedUser3 = User.create(
        email: 'tester@test.com',
        name: 'Testere',
        password: '1235678910',
        password_confirmation: '1235678910'
      )
      expect(User.authenticate_with_credentials('  tester@test.com', '1235678910')).to eq @authenticatedUser3
    end

    it 'Should return instance of user when credentials are correct and a visitor types in a few spaces after their email address' do
      @authenticatedUser4 = User.create(
        email: 'tester@test.com',
        name: 'Testere',
        password: '1235678910',
        password_confirmation: '1235678910'
      )
      expect(User.authenticate_with_credentials('tester@test.com  ', '1235678910')).to eq @authenticatedUser4
    end

    it 'Should return instance of user when credentials are correct and a visitor types in a few spaces before and after their email address' do
      @authenticatedUser5 = User.create(
        email: 'tester@test.com',
        name: 'Testere',
        password: '1235678910',
        password_confirmation: '1235678910'
      )
      expect(User.authenticate_with_credentials('  tester@test.com  ', '1235678910')).to eq @authenticatedUser5
    end

    it 'Should return instance of user a visitor types in the wrong case for their email' do
      @authenticatedUser6 = User.create(
        email: 'eXample@domain.COM',
        name: 'Testere',
        password: '1235678910',
        password_confirmation: '1235678910'
      )
      expect(User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', '1235678910')).to eq @authenticatedUser6
    end
  end
end
