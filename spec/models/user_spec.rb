require 'rails_helper'

RSpec.describe User, type: :model do
  context 'has valid attributes' do
    it "should save" do
      expect(build(:user)).to be_valid
    end
    it 'encrypts the password' do
      expect(build(:user).password_digest.present?).to eq(true)
    end
    it 'lowercases email by default'do
      expect(create(:user, email:'MAIL@MAIL.COM').email).to eq('mail@mail.com')
    end
  end
  context 'has invalid attributes' do
    it 'if name is blank' do
      expect(build(:user, name:"")).to be_invalid
    end
    it 'if email is blank' do
      expect(build(:user, email: "")).to be_invalid
    end
    it 'if email format is wrong' do
      emails = %w[@ user@ @example.com]
      emails.each do |email|
        expect(build(:user, email: email)).to be_invalid
      end
    end
    it 'if email is not unique' do
      create(:user)
      expect(build(:user)).to be_invalid
    end
    it 'if password is blank' do
      expect(build(:user,password:"")).to be_invalid
    end
    it "if password doesn't match confirm" do
      expect(build(:user, password_confirmation: "notpassword")).to be_invalid
    end
  end
  context 'relationships' do
    before do
      @user = create(:user)
      @secret = create(:secret, content: 'secret 1', user: @user)
      @like = create(:like, secret: @secret, user: @user)
    end
    it 'has secrets' do
      expect(@user.secrets).to include(@secret)
    end
    it 'has likes' do
      expect(@user.likes).to include(@like)
    end
    it "has secrets through likes table" do
      expect(@user.secrets_liked).to include(@secret)
    end
  end
end
