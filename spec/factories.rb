# This will guess the User class
FactoryGirl.define do
  factory :feed_item do
    feed_name "test_feed"
    title "Test feed item"
    description "Test feed description"
  end
end