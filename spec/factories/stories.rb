# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title "MyString"
    announce "MyString"
    author "MyString"
    avatar_url "MyString"
    cover_url "MyString"
    url "MyString"
    body "MyText"
    feed_id 1
    time_marker "MyString"
    state "MyString"
  end
end
