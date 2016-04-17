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

    it "is public by default" do
      expect(wiki.private).to be(false)
    end
  end

  describe "scopes" do
    let(:private_wiki) { Wiki.create!(title: "Private Wiki", body: "This is a private wiki.", private: true, user: user)}
    let(:other_user) { User.create!(username: "Other User", email: "other@other.other", password: "helloworld")}
    let(:other_user_wiki) { Wiki.create!(title: "Someone else's private wiki", body: "Someone elses wiki.", private: true, user: other_user)}

    describe "visible_to(user)" do
      it "returns all public wikis" do
        expect(Wiki.visible_to(user)).to eq(Wiki.where(private: false))
      end

      it "returns a user's private wikis" do
        expect(Wiki.visible_to(user)).to include(Wiki.where(user: user, private: true))
      end

      it "doesn't show other_user's private wiki" do
        expect(Wiki.visible_to(user)).not_to include(other_user_wiki)
      end
    end
  end
end
