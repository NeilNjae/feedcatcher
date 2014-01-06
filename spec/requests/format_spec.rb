require 'spec_helper'

describe "format" do
  let!(:feed_item1) { FactoryGirl.create(:feed_item, 
      title: "item 1") }
  let!(:feed_item2) { FactoryGirl.create(:feed_item, 
      title: "item 2") }
  let!(:other_feed_item) { FactoryGirl.create(:feed_item, 
      feed_name: "other_test_feed") }

  it "changes the description of an existing item" do
    post_via_redirect '', 
      FactoryGirl.attributes_for(:feed_item, 
              title: "item 1", description: "New description")
    expect(assigns(:feed_items).map{|f| f.description}).to include("New description")
    expect(assigns(:feed_items).length).to eq(2)
    get '/index'
    expect(assigns(:feeds).length).to eq(2)
  end
  
  it "adds the item when inserting a new title into an existing feed" do
    post_via_redirect '', 
      FactoryGirl.attributes_for(:feed_item, title: "item 99", 
                                 description: "New description")
    expect(assigns(:feed_items).map{|f| f.description}).to include("New description")
    expect(assigns(:feed_items).length).to eq(3)
    get '/index'
    expect(assigns(:feeds).length).to eq(2)
  end
    
  it "adds a new feed when inserting a new item into a new feed" do
    post_via_redirect '', 
      FactoryGirl.attributes_for(:feed_item, feed_name: "new_feed")
    expect(assigns(:feed_items).length).to eq(1)
    expect(assigns(:feed_items)[0].feed_name).to eq("new_feed")
    get '/index'
    expect(assigns(:feeds).length).to eq(3)
  end
    
  it "removes the item when updated with a blank description" do
    post_via_redirect '', 
      FactoryGirl.attributes_for(:feed_item, title: "item 1", 
                                 description: "")
    expect(assigns(:feed_items).map{|f| f.title}).not_to include("item 1")
    expect(assigns(:feed_items).length).to eq(1)
    get '/index'
    expect(assigns(:feeds).length).to eq(2)
  end
    
  it "removes the feed when deleting the last item from a feed" do
    post_via_redirect '', 
      FactoryGirl.attributes_for(:feed_item, feed_name: "other_test_feed",
                                 description: "")
    get '/index'
    expect(assigns(:feeds).length).to eq(1)
  end
end

