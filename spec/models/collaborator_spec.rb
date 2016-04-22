require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }

  let(:user) { User.create!(username: "Test User", email: "test@test.test", password: "helloworld")}
  let(:wiki) { Wiki.create!(title: "Test Wiki", body: "This is a test wiki entry.", private: false, user: user)}

  describe "mailer callback" do
    before do
      @collaborator = Collaborator.new(user: user, wiki: wiki)
    end

    it "emails collaborators" do
      expect(CollaboratorMailer).to receive(:new_collaborator).with(@collaborator).and_return(double(deliver_now: true))

      @collaborator.save!
    end
  end
end
