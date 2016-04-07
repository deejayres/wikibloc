require 'rails_helper'

describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  let(:user) { User.create!(username: "Test User", email: "test@test.test", password: "helloworld")}
  let(:other_user) { User.create!(username: "Other User", email: "test2@test.test", password: "helloworld")}

  context "for standard user, other public wiki" do
    let(:wiki) { FactoryGirl.create(:wiki, user: other_user)}
    it { should permit_action(:show)   }
    it { should permit_action(:new)    }
    it { should permit_action(:create) }
    it { should permit_action(:edit)   }
    it { should permit_action(:update) }

    it { should forbid_action(:destroy)}
  end

  context "for standard user, their own public wiki" do
    let(:wiki) { FactoryGirl.create(:wiki, user: user)}
    it { should permit_action(:destroy)}
  end


end
