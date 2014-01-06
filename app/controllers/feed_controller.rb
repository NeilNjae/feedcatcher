class FeedController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def index
    # @feeds = FeedItem.find(:all, :select => 'DISTINCT feed_name')
    @feeds = FeedItem.select(:feed_name).distinct
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  
  def show
    if FeedItem::valid_feed_name?(params[:feed_name])
      @feed_name = params[:feed_name]
      @feed_items = FeedItem.in_feed(@feed_name)
      respond_to do |format|
        if @feed_items == []
          flash[:notice] = "No items in feed #{@feed_name}"
          format.html { redirect_to index_path }
          format.rss  { render :layout => false }
        else
          format.html
          format.rss { render :layout => false }
        end
      end
    else
      respond_to do |format|
        flash[:notice] = "Invalid feed name"
        format.html { redirect_to index_path }
        format.rss  { head :not_found}
      end
    end
  end


  def update
    if FeedItem::valid_feed_name?(params[:feed_name])
      item = FeedItem.in_feed(params[:feed_name]).entitled(params[:title]).take
      if item
        if params[:description].empty?
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
        format.html { redirect_to index_path }
        format.rss  { head :not_found }
      end
    end
  end
  

  private


  def create_item
    item = FeedItem.new(:feed_name => params[:feed_name],
      :title => params[:title],
      :description => params[:description])
    item.save!
    flash[:notice] = "Element #{params[:title]} created"
    respond_to do |format|
      format.html { redirect_to feed_path(params[:feed_name]) }
      format.rss  { head :ok }
    end
  rescue ActiveRecord::RecordInvalid => error
    flash[:notice] = "Element #{params[:title]} could not be created"
    respond_to do |format|
      format.html { redirect_to feed_path(params[:feed_name]) }
      format.rss  { head :unprocessable_entity }
    end
  end


  def update_item(item)
    if item.update_attribute(:description, params[:description])
      flash[:notice] = "Element #{params[:title]} updated"
      respond_to do |format|
        format.html { redirect_to feed_path(params[:feed_name]) }
        format.rss  { head :ok }
      end
    else
      flash[:notice] = "Element #{params[:title]} could not be updated"
      respond_to do |format|
        format.html { redirect_to feed_path(params[:feed_name]) }
        format.rss  { head :unprocessable_entity }
      end
    end
  end


  def destroy_item(item)
    if item.destroy
      flash[:notice] = "Element #{params[:title]} deleted"
      respond_to do |format|
        format.html { redirect_to feed_path(params[:feed_name]) }
        format.rss  { head :ok }
      end
    else
      flash[:notice] = "Element #{params[:title]} could not be deleted"
      respond_to do |format|
        format.html { redirect_to feed_path(params[:feed_name]) }
        format.rss  { head :unprocessable_entity }
      end
    end
  end

end
