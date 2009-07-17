class FeedController < ApplicationController

  skip_before_filter :verify_authenticity_token

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
    item = FeedItem.find_by_feed_name_and_title(params[:feed_name], params[:title])
    if item
      if params[:description] == ''
        item.destroy
      else
        item.update_attribute(:description, params[:description])
      end
    else
      FeedItem.create(:feed_name => params[:feed_name],
        :title => params[:title],
        :description => params[:description])
    end
    redirect_to feed_url(params[:feed_name])
  end

end
