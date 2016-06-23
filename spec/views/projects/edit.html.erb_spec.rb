require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :user => nil,
      :title => "MyString",
      :content => "MyText",
      :client_id => 1,
      :client => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_user_id[name=?]", "project[user_id]"

      assert_select "input#project_title[name=?]", "project[title]"

      assert_select "textarea#project_content[name=?]", "project[content]"

      assert_select "input#project_client_id[name=?]", "project[client_id]"

      assert_select "input#project_client[name=?]", "project[client]"
    end
  end
end
