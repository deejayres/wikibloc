require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(username: "Test User", email: "test@test.test", password: "helloworld")}
  let(:wiki) { Wiki.create!(title: "Test Wiki", body: "This is a test wiki entry.", private: false, user: user)}

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "responds to title" do
      expect(wiki).to respond_to(:title)
    end

    it "responds to body" do
      expect(wiki).to respond_to(:body)
    end

    it "responds to private" do
      expect(wiki).to respond_to(:private)
    end
  end
end
