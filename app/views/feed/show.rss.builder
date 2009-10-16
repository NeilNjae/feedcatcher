# show.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @feed_name
    xml.link feed_url(@feed_name, :rss)
    xml.description "The #{h @feed_name} feed"

    for item in @feed_items
      xml.item do
        xml.title item.title
        xml.description item.description
        xml.guid item.id, :isPermaLink => 'false'
        xml.pubDate(item.updated_at.to_s(:rfc822))
      end
    end
  end
end
