require 'rails_helper'

RSpec.describe Amount, type: :model do
  describe "responds to #default" do
    it "sets default amount to constant" do
      expect(Amount.default).to eq(15_00)
    end
  end
end
