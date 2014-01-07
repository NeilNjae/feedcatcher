require 'spec_helper'

describe FeedItem do
 
  it "is valid with valid attributes" do
    feed_item = FactoryGirl.build(:feed_item)
    expect(feed_item).to be_valid
  end

  it "is not valid without a feed name" do
    feed_item = FactoryGirl.build(:feed_item, feed_name: nil)
    expect(feed_item).not_to be_valid
  end

  it "is not valid without a title" do
    feed_item = FactoryGirl.build(:feed_item, title: nil)
    expect(feed_item).not_to be_valid
  end

  it "is not valid without a description" do
    feed_item = FactoryGirl.build(:feed_item, description: nil)
    expect(feed_item).not_to be_valid
  end

  it "is not valid with an improper feed name" do
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed%20name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed&name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed%26name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed<name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed%3Cname')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'feed%name')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'index')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'show')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'update')
    expect(feed_item).not_to be_valid
    feed_item = FactoryGirl.build(:feed_item, feed_name: 'action')
    expect(feed_item).not_to be_valid
  end
end
