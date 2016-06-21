FactoryGirl.define do
  factory :task do
    user nil
    title "MyString"
    content "MyText"
    deadline "2016-06-16 02:47:03"
    charge_id 1
    done false
    status 1
  end
end
