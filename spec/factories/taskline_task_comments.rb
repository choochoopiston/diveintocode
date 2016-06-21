FactoryGirl.define do
  factory :taskline_task_comment, class: 'Taskline::TaskComment' do
    user nil
    task nil
    content "MyString"
  end
end
