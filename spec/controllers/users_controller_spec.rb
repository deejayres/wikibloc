require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) { FactoryGirl.create(:user) }

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

end
