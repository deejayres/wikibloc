require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) { FactoryGirl.create(:user) }
  let(:my_wiki) { FactoryGirl.create(:wiki, user: my_user, private: true) }

  describe "GET #show" do
    it "returns http success" do
      sign_in my_user
      get :show

      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      sign_in my_user
      get :show

      expect(response).to render_template(:show)
    end

    it "it assigns my_user to @user" do
      sign_in my_user
      get :show

      expect(assigns(:user)).to eq(my_user)
    end
  end

  describe "POST #downgrade" do
    before(:each) do
      my_user.add_role :premium
      sign_in my_user
      FactoryGirl.create(:wiki, user: my_user, private: true)
    end

    after(:each) do
      sign_out my_user
    end

    it "removes premium role" do
      post :downgrade

      expect(my_user.is_premium?).to be(false)
    end

    it "makes private wiki public" do
      post :downgrade
  
      expect(my_user.wikis.first.private).to be(false)
    end
  end

end
