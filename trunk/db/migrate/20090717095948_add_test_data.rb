class AddTestData < ActiveRecord::Migration
  def self.up
    FeedItem.delete_all
    (1..20).each do |item_number|
      ('a'..'j').each do |feed_name|
        FeedItem.create(:feed_name => "feed-#{feed_name}",
          :title => "feed-#{feed_name}-item-" + sprintf("%02d", item_number),
          :description => "Feed #{feed_name}, Item #{item_number} has a description")
      end
    end
  end

  def self.down
    FeedItem.delete_all
  end
end
