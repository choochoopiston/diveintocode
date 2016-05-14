require 'rails_helper'

RSpec.describe "About Page", type: :request do
  describe "company_overview page" do
    it "should have the content '会社概要'" do
      visit '/about'
      expect(page).to have_content("会社概要")
    end
  end
end
