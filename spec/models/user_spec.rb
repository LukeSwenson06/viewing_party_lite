require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { should have_many :viewing_partys }
    it { should have_many :attendees }
    it { should have_many(:viewing_partys).through(:attendees) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should have_secure_password }
  end

    it "can test the password attribute " do
      user = User.create(user_name: "Luke", email: "luke@test.com", password: "test123", password_confirmation: "test123")
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('test123')
  end
end
