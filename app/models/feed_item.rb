class FeedItem < ActiveRecord::Base

  # require 'cgi' # needed for url decoding

  validates_presence_of :feed_name, :title, :description
  validate :feed_name_must_be_legal

protected

  def feed_name_must_be_legal
    if Rack::Utils::escape(feed_name) != feed_name or
        Rack::Utils::unescape(feed_name) != feed_name or
        feed_name == 'index' or
        feed_name == 'show' or
        feed_name == 'update' or
        feed_name == 'action'
      errors.add(:feed_name, 'is an invalid feed name')
    end
  end

end
