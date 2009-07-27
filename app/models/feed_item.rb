class FeedItem < ActiveRecord::Base

  # require 'cgi' # needed for url decoding

  validates_presence_of :feed_name, :title, :description
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
      errors.add(:feed_name, 'is an invalid feed name')
    end
  end

end
