require 'spec_helper'

describe FeedController do
#   describe "POST create" do
#     let (:feed_item1) { mock_model(FeedItem).as_null_object }
#     
#     before do
#       FeedItem.stub(:new).and_return(feed_item)
#     end
#   end
    
  describe "GET #index" do
    let!(:feed_item1) { FactoryGirl.create(:feed_item, feed_name: "feed1") }
    let!(:feed_item2) { FactoryGirl.create(:feed_item, feed_name: "feed2") }

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
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
    let!(:feed_item1) { FactoryGirl.create(:feed_item, feed_name: "test_feed", title: "item 1") }
    let!(:feed_item2) { FactoryGirl.create(:feed_item, feed_name: "test_feed", title: "item 2") }
    
    it "redirects an emtpy feed to the index" do
      get :show, feed_name: "empty_feed"
      expect(response).to redirect_to(index_path)
    end 
    
    it "responds successfully with an HTTP 200 status code" do
      get :show, feed_name: "test_feed"
      expect(response).to be_success
      expect(response.status).to eq(200)
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
  
  
end


# describe MessagesController do
# describe "POST create" do
# let(:message) { mock_model(Message).as_null_object }
# before do
# Message.stub(:new).and_return(message)
# end
# it "creates a new message" do
# Message.should_receive(:new).
# with("text" => "a quick brown fox").
# and_return(message)
# post :create, :message => { "text" => "a quick brown fox" }
# end
# it "saves the message" do
# message.should_receive(:save)
# post :create
# end
# it "redirects to the Messages index" do
# post :create
# response.should redirect_to(:action => "index")
# end
# end
# end
# 
