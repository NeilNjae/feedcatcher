class FeedController < ApplicationController
  def index
    @feeds = FeedItem.find(:all, :select => 'DISTINCT feed_name')
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @feed_items = FeedItem.find_all_by_feed_name(params[:feed_name])
    redirect_to index_url if @feed_items == []
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def update
    item = FeedItem.find_by_feed_name_and_title(params[:feed_item][:feed_name], params[:feed_item][:title])
    if item
      if params[:feed_item][:description] == ''
        item.destroy
      else
        item.update_attribute(:description, params[:feed_item][:description])
      end
    else
      FeedItem.create(params[:feed_item])
    end
    redirect_to feed_url(params[:feed_item][:feed_name])
  end

end
