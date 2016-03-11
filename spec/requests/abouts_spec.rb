require 'rails_helper'

RSpec.describe "Abouts", type: :request do
  describe "company_overview page" do
    it "should have the content '会社概要'" do
      visit '/about'
      expect(response).to have_content("会社概要")
    end
  end
end
