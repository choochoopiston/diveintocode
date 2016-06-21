require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :user => nil,
      :title => "Title",
      :content => "MyText",
      :client_id => 1,
      :client => "Client"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Client/)
  end
end
