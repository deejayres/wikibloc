require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  before(:each) do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
    @my_wiki = FactoryGirl.create(:wiki, user: @my_user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      expect(@my_user.wikis.first).to eq(@my_wiki)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: @my_wiki.id}

      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, {id: @my_wiki.id}

      expect(response).to render_template(:show)
    end

    it "assigns @my_wiki to @wiki" do
      get :show, {id: @my_wiki.id}

      expect(assigns(:wiki)).to eq(@my_wiki)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new

      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new

      expect(response).to render_template(:new)
    end

    it "instantiates @wiki" do
      get :new

      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increases the number of Wiki by 1" do
      expect{post :create, wiki: {title: "Wiki Title", body: "Wiki Body"}}.to change(Wiki, :count).by(1)
    end

    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: "Wiki Title", body: "Wiki Body"}

      expect(assigns(:wiki)).to eq(Wiki.last)
    end

    it "redirects to to the new wiki" do
      post :create, wiki: {title: "Wiki Title", body: "Wiki Body"}

      expect(response).to redirect_to(Wiki.last)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: @my_wiki.id}

      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: @my_wiki.id}

      expect(response).to render_template(:edit)
    end

    it "assigns the wiki to be updated to @wiki" do
      get :edit, {id: @my_wiki.id}
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq(@my_wiki.id)
      expect(wiki_instance.title).to eq(@my_wiki.title)
      expect(wiki_instance.body).to eq(@my_wiki.body)
    end
  end

  describe "PUT #update" do
    it "updates wiki with expected attributes" do
      new_title = Faker::Hipster.sentence(4)
      new_body = Faker::Hipster.paragraph(5)
      put :update, id: @my_wiki.id, wiki: {title: new_title, body: new_body}
      updated_wiki = assigns(:wiki)

      expect(updated_wiki.id).to eq(@my_wiki.id)
      expect(updated_wiki.title).to eq(new_title)
      expect(updated_wiki.body).to eq(new_body)
    end

    it "redirects to updated wiki" do
      new_title = Faker::Hipster.sentence(4)
      new_body = Faker::Hipster.paragraph(5)
      put :update, id: @my_wiki.id, wiki: {title: new_title, body: new_body}

      expect(response).to redirect_to(@my_wiki)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the wiki" do
      delete :destroy, {id: @my_wiki.id}
      count = Wiki.where({id: @my_wiki.id}).size

      expect(count).to eq(0)
    end

    it "redirects to wiki index" do
      delete :destroy, {id: @my_wiki.id}

      expect(response).to redirect_to(wikis_path)
    end
  end

end
