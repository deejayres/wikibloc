require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  before(:each) do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
  end

  describe "charging customer" do
    it "returns successful charge" do
      # post :create

    end
  end
end
