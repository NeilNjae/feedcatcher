require 'spec_helper'

describe FeedController do    
  describe "GET #index" do
    let!(:feed_item1) { FactoryGirl.create(:feed_item, feed_name: "feed1") }
    let!(:feed_item2) { FactoryGirl.create(:feed_item, feed_name: "feed2") }

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all the feed names into @feeds" do
      get :index
      expect(assigns(:feeds).map {|f| f.feed_name}).to match_array(["feed1", "feed2"])
    end
  end

  describe "GET #feed" do
    let!(:feed_item1) { FactoryGirl.create(:feed_item, 
      feed_name: "test_feed", title: "item 1") }
    let!(:feed_item2) { FactoryGirl.create(:feed_item, 
      feed_name: "test_feed", title: "item 2") }
    
    it "redirects an emtpy html feed to the index" do
      get :show, feed_name: "empty_feed"
      expect(response).to redirect_to(index_path)
    end 

    it "does not redirect an emtpy rss document for an empty feed" do
      get :show, feed_name: "empty_feed", format: "rss"
      expect(response).to be_success
    end 

    it "returns an emtpy rss document for an empty feed" do
      get :show, feed_name: "empty_feed", format: "rss"
      expect(assigns(:feed_items)).to be_empty
    end 
    
    it "responds successfully with an HTTP 200 status code" do
      get :show, feed_name: "test_feed"
      expect(response).to be_success
    end

    it "renders the index template" do
      get :show, feed_name: "test_feed"
      expect(response).to render_template("show")
    end

    it "loads all of the items of a feed into @feed_items" do
      get :show, feed_name: "test_feed"
      expect(assigns(:feed_items)).to match_array([feed_item1, feed_item2])
    end
  end


  describe "POST #feed" do
    let!(:feed_item1) { FactoryGirl.create(:feed_item, 
      title: "item 1") }
    let!(:feed_item2) { FactoryGirl.create(:feed_item, 
      title: "item 2") }
    let!(:other_feed_item) { FactoryGirl.create(:feed_item, 
      feed_name: "other_test_feed", title: "item") }
    
    it "redirects an update the feed path" do
      post :update, FactoryGirl.attributes_for(:feed_item, 
                title: "item 1", description: "New description")
      expect(response).to redirect_to(feed_path("test_feed"))
    end
  end
end
