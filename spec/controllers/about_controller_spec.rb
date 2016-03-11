require 'rails_helper'

RSpec.describe AboutController, type: :controller do

  describe "GET #company_overview" do
    it "returns http success" do
      get :company_overview
      expect(response).to have_http_status(:success)
    end
  end

end
