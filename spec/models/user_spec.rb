require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(username: "Test User", email: "test@test.test", password: "helloworld")}

  describe "roles" do
    it "defaults to standard" do
      expect(user.is_standard?).to be_truthy
      expect(user.is_premium?).to be_falsey
      expect(user.is_admin?).to be_falsey
    end

    it "emails upgraded users" do
      expect(PremiumMailer).to receive(:premium_upgrade).with(user).and_return(double(deliver_now: true))

      user.add_role :premium
    end
  end

end
