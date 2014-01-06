class FeedItem < ActiveRecord::Base
  
  def self.in_feed(name)
    where('feed_name = ?', name)
  end
  
  def self.entitled(title)
    where('title = ?', title)
  end
  
  validates_presence_of :feed_name, :title, :description
  validates_uniqueness_of :title, :scope => :feed_name
  validate :feed_name_must_be_legal

  def FeedItem.valid_feed_name?(feed_name)
    Rack::Utils::escape(feed_name) == feed_name and
      Rack::Utils::unescape(feed_name) == feed_name and
      feed_name != 'index' and
      feed_name != 'show' and
      feed_name != 'update' and
      feed_name != 'action'
  end

  private

  def feed_name_must_be_legal
    unless FeedItem.valid_feed_name?(feed_name)
      errors.add(:feed_name, 'is invalid')
    end
  end
end
