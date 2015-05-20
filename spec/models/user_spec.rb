require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(email: "user@example.com", password: 'foobarbaz', password_confirmation: 'foobarbaz')
  end

  subject { @user }
  it { should be_valid }

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user.password = 'foo'
      @user.password_confirmation = 'foo'
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = ' ' * 10 }
    it { should_not be_valid }
  end

  describe "when password is different to password confirmation" do
    before { @user.password = 'hogefuga' }
    it { should_not be_valid }
  end

  describe "when email is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email has big letters" do
    before do
      @user.email = "UseR@ExAMple.Com"
      @user.save
    end
    it "email should equal to downcase" do
      expect(@user.reload.email).to eq("user@example.com")
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = User.new(email: "USER@examPLe.com", password: 'hogefuga', password_confirmation: 'hogefuga')
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
end