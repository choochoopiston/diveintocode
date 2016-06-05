require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :title => "MyString",
      :course => "MyString",
      :category => "MyString",
      :content => "MyText",
      :user => nil
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "input#question_title[name=?]", "question[title]"

      assert_select "input#question_course[name=?]", "question[course]"

      assert_select "input#question_category[name=?]", "question[category]"

      assert_select "textarea#question_content[name=?]", "question[content]"

      assert_select "input#question_user_id[name=?]", "question[user_id]"
    end
  end
end
