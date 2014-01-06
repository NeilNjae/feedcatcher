require 'spec_helper'

describe "update" do
  let!(:feed_item1) { FactoryGirl.create(:feed_item, 
      title: "item 1") }
  let!(:feed_item2) { FactoryGirl.create(:feed_item, 
      title: "item 2") }
  let!(:other_feed_item) { FactoryGirl.create(:feed_item, 
      feed_name: "other_test_feed") }

  it "serves index as html by default" do
    get_via_redirect '/index'
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves index.html as html" do
    get_via_redirect '/index.html'
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves index.rss as rss" do
    get_via_redirect '/index.rss'
    expect(response.header['Content-Type']).to include('application/rss+xml')
  end
  
  it "serves index as html with the accept header" do
    get_via_redirect '/index', {}, {'Accept' => 'text/html'}
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves index as rss with the accept header" do
    get_via_redirect '/index', {}, {'Accept' => 'application/rss+xml'}
    expect(response.header['Content-Type']).to include('application/rss+xml')
  end

  it "serves feed as html by default" do
    get_via_redirect '/other_test_feed'
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves feed.html as html" do
    get_via_redirect '/other_test_feed.html'
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves feed.rss as rss" do
    get_via_redirect '/other_test_feed.rss'
    expect(response.header['Content-Type']).to include('application/rss+xml')
  end
  
  it "serves feed as html with the accept header" do
    get_via_redirect '/other_test_feed', {}, {'Accept' => 'text/html'}
    expect(response.header['Content-Type']).to include('text/html')
  end

  it "serves feed as rss with the accept header" do
    get_via_redirect '/other_test_feed', {}, {'Accept' => 'application/rss+xml'}
    expect(response.header['Content-Type']).to include('application/rss+xml')
  end
end
