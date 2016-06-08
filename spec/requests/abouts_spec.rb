require 'rails_helper'

<<<<<<< HEAD
RSpec.describe "Abouts", type: :request do
  describe "company_overview page" do
    it "should have the content '会社概要'" do
      visit '/about'
      expect(response).to have_content("会社概要")
=======
RSpec.describe "About Page", type: :request do
  describe "company_overview page" do
    it "should have the content '会社概要'" do
      visit '/about'
      expect(page).to have_content("会社概要")
>>>>>>> deccc4da04dab670391355a8a9349c6d7167786f
    end
  end
end
