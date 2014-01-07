require 'spec_helper'

describe "format" do

  it "serves index as html by default" do
    get_via_redirect '/index'
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves index.html as html" do
    get_via_redirect '/index.html'
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves index.rss as rss" do
    get_via_redirect '/index.rss'
    expect(response.header['Content-Type']).to include('application/rss+xml')
    expect(response.header['Content-Type']).not_to include('text/html')
  end
  
  it "serves index as html with the accept header" do
    get_via_redirect '/index', {}, {'Accept' => 'text/html'}
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves index as rss with the accept header" do
    get_via_redirect '/index', {}, {'Accept' => 'application/rss+xml'}
    expect(response.header['Content-Type']).to include('application/rss+xml')
    expect(response.header['Content-Type']).not_to include('text/html')
  end

  it "serves feed as html by default" do
    get_via_redirect '/other_test_feed'
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves feed.html as html" do
    get_via_redirect '/other_test_feed.html'
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves feed.rss as rss" do
    get_via_redirect '/other_test_feed.rss'
    expect(response.header['Content-Type']).to include('application/rss+xml')
    expect(response.header['Content-Type']).not_to include('text/html')
  end
  
  it "serves feed as html with the accept header" do
    get_via_redirect '/other_test_feed', {}, {'Accept' => 'text/html'}
    expect(response.header['Content-Type']).to include('text/html')
    expect(response.header['Content-Type']).not_to include('application/rss+xml')
  end

  it "serves feed as rss with the accept header" do
    get_via_redirect '/other_test_feed', {}, {'Accept' => 'application/rss+xml'}
    expect(response.header['Content-Type']).to include('application/rss+xml')
    expect(response.header['Content-Type']).not_to include('text/html')
  end
end

