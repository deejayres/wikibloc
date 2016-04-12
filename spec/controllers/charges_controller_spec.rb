require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do

  before(:each) do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
  end

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "charging customer" do
    it "creates a customer" do
      customer = Stripe::Customer.create({
        email: @my_user.email,
        card: stripe_helper.generate_card_token
      })

      expect(customer.email).to eq(@my_user.email)
      expect(customer.card).to be_truthy
    end

    it "creates and has successful charge" do
      customer = Stripe::Customer.create({
        email: @my_user.email,
        card: stripe_helper.generate_card_token
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: Amount.default,
        currency: 'usd'
      })

      expect(charge.paid).to eq(true)
    end

    it "upgrades user to premium" do
      post :create

      expect(@my_user.is_premium?).to be(true)
    end

    it "redirect to wikis if user is already premium" do
      @my_user.add_role :premium
      post :create

      expect(response).to redirect_to(wikis_path)
    end
  end
end
