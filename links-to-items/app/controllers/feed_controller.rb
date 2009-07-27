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
    if valid_feed_name?(params[:feed_name])
      @feed_items = FeedItem.find_all_by_feed_name(params[:feed_name])
      @feed_name = params[:feed_name]
      respond_to do |format|
        if @feed_items == []
          flash[:notice] = "No items in feed #{params[:feed_name]}"
          format.html { redirect_to index_url }
          format.rss  { render :layout => false }
        else
          format.html
          format.rss { render :layout => false }
        end
      end
    else
      respond_to do |format|
        flash[:notice] = "Invalid feed name"
        format.html { redirect_to index_url }
        format.rss  { head :not_found}
      end
    end
  end


  def update
    if valid_feed_name?(params[:feed_name])
      item = FeedItem.find_by_feed_name_and_title(params[:feed_name], params[:title])
      if item
        if params[:description] == ''
          destroy_item(item)
        else
          update_item(item)
        end
      else
        create_item
      end
    else
      respond_to do |format|
        flash[:notice] = "Invalid feed name"
        format.html { redirect_to index_url }
        format.rss  { head :not_found }
      end
    end
  end
  

  private

  def valid_feed_name?(feed_name)
    Rack::Utils::escape(feed_name) == feed_name and
      Rack::Utils::unescape(feed_name) == feed_name and
      feed_name != 'index' and
      feed_name != 'show' and
      feed_name != 'update' and
      feed_name != 'action'
  end


  def create_item
    item = FeedItem.new(:feed_name => params[:feed_name],
      :title => params[:title],
      :description => params[:description])
    item.save!
    flash[:notice] = "Element #{params[:title]} created"
    respond_to do |format|
      format.html { redirect_to feed_url(params[:feed_name]) }
      format.rss  { head :ok }
    end
  rescue ActiveRecord::RecordInvalid => error
    flash[:notice] = "Element #{params[:title]} could not be created"
    respond_to do |format|
      format.html { redirect_to feed_url(params[:feed_name]) }
      format.rss  { head :unprocessable_entity }
    end
  end


  def update_item(item)
    if item.update_attribute(:description, params[:description])
      flash[:notice] = "Element #{params[:title]} updated"
      respond_to do |format|
        format.html { redirect_to feed_url(params[:feed_name]) }
        format.rss  { head :ok }
      end
    else
      flash[:notice] = "Element #{params[:title]} could not be updated"
      respond_to do |format|
        format.html { redirect_to feed_url(params[:feed_name]) }
        format.rss  { head :unprocessable_entity }
      end
    end
  end


  def destroy_item(item)
    if item.destroy
      flash[:notice] = "Element #{params[:title]} destroyed"
      respond_to do |format|
        format.html { redirect_to feed_url(params[:feed_name]) }
        format.rss  { head :ok }
      end
    else
      flash[:notice] = "Element #{params[:title]} could not be destroyed"
      respond_to do |format|
        format.html { redirect_to feed_url(params[:feed_name]) }
        format.rss  { head :unprocessable_entity }
      end
    end
  end

end
