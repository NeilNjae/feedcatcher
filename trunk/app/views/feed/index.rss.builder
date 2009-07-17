# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Feedcatcher"
    xml.description "Feeds available"
    xml.link index_url(:rss)

    for feed in @feeds
      xml.item do
        xml.title feed.feed_name
        xml.link feed_url(feed.feed_name, :rss)
        xml.guid feed_url(feed.feed_name, :rss)
      end
    end
  end
end
