require 'rails_helper'

RSpec.describe SubmitRequestsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #approve" do
    it "returns http success" do
      get :approve
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unapprove" do
    it "returns http success" do
      get :unapprove
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #reject" do
    it "returns http success" do
      get :reject
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #inbox" do
    it "returns http success" do
      get :inbox
      expect(response).to have_http_status(:success)
    end
  end

end
