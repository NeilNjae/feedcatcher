# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FeedItem.delete_all
(1..20).each do |item_number|
  ('a'..'j').each do |feed_name|
    FeedItem.create(:feed_name => "feed-#{feed_name}",
      :title => "feed-#{feed_name}-item-" + sprintf("%02d", item_number),
      :description => "Feed #{feed_name}, Item #{item_number} has a description")
  end
end