require 'spec_helper'

describe "routes for feedcatcher" do
  it "routes / to index" do
    expect(get('/')).to route_to('feed#index')
  end

  it "routes /index(.:format) to feed#index" do
    expect(get('/index')).to route_to('feed#index')
    expect(get('/index.html')).to route_to(controller: 'feed', 
                                           action: 'index', format: 'html')
    expect(get('/index.rss')).to route_to(controller: 'feed', 
                                          action: 'index', format: 'rss')
  end

  it "routes /:feed_name.:format) to feed" do
    expect(get('/myfeed')).to route_to(controller: 'feed', 
                                       action: 'show', feed_name: 'myfeed')
    expect(get('/myfeed.html')).to route_to(controller: 'feed', 
                                            action: 'show', 
                                            feed_name: 'myfeed', 
                                            format: 'html')
    expect(get('/myfeed.rss')).to route_to(controller: 'feed', 
                                           action: 'show', 
                                           feed_name: 'myfeed', 
                                           format: 'rss')
  end
end
