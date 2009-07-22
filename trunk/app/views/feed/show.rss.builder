# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @feed_name
    xml.link feed_url(@feed_name, :rss)

    for item in @feed_items
      xml.item do
        xml.title item.title
        xml.description item.description
        xml.guid item.id, :isPermaLink => 'false'
      end
    end
  end
end
