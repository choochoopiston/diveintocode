require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        :user => nil,
        :title => "Title",
        :content => "MyText",
        :client_id => 1,
        :client => "Client"
      ),
      Project.create!(
        :user => nil,
        :title => "Title",
        :content => "MyText",
        :client_id => 1,
        :client => "Client"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Client".to_s, :count => 2
  end
end
