require 'rails_helper'

RSpec.describe User, type: :model do

  describe "db schema" do
    context "columns" do
      it { should have_db_column(:email).of_type(:string) }
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:phone).of_type(:string) }
      it { should have_db_column(:biography).of_type(:text) }
    end
  end
  describe "User validation" do
    context "validations " do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password) }
    end
    context "associations" do
      it {is_expected.to have_many :socials}
      it {is_expected.to have_many :posts}
      it {is_expected.to have_many :participates}
      it {is_expected.to have_many :projects}
      it {is_expected.to have_many :techniques}
      it {is_expected.to have_many :messages}
      it {is_expected.to have_many :certificate_users}
      it {is_expected.to have_many :certifications}
      it {is_expected.to have_many :likes}
      it {is_expected.to have_many :target_techniques}
      it {is_expected.to have_many :notifications}
    end
  end

  auth_hash = OmniAuth::AuthHash.new({
    provider: "facebook",
    uid: "1994",
    info: {
      email: "ngocthinh@example.com",
      name: "ngocthinh"
    }
  })

  describe ".from_omniauth" do
    it "retrieves an existing user" do
      user = FactoryGirl.create(:user,
        provider: "facebook",
        uid: 1994,
        name: "ngocthinh",
        email: "ngocthinh@example.com",
        password: "password",
        password_confirmation: "password"
        )
      user.save
      omniauth_user = User.from_omniauth(auth_hash)
      expect(user).to eq(omniauth_user)
    end
    it "create new user if exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end
end
