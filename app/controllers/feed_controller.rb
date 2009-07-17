class FeedController < ApplicationController
  def index
    @feeds = FeedItem.find(:all, :select => 'DISTINCT feed_name')
  end

  def show
    @feed_items = FeedItem.find_all_by_feed_name(params[:id])
  end

  def update
  end

end
