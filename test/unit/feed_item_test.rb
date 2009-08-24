require 'test_helper'

class FeedItemTest < ActiveSupport::TestCase

  fixtures :feed_items

  test "invalid with empty attributes" do
    feed_item = FeedItem.new
    assert !feed_item.valid?
    assert feed_item.errors.invalid?(:feed_name)
    assert feed_item.errors.invalid?(:title)
    assert feed_item.errors.invalid?(:description)
  end

  test "illegal feed names" do
    bad_feed_names = ["name with spaces", "name%20with%20spaces", "action", "index", "show", "update"]

    bad_feed_names.each do |feed_name|
      feed_item = FeedItem.new(:feed_name => feed_name,
        :title => "Sample title",
        :description => "Sample description")
      assert !feed_item.valid?
      assert_equal "is an invalid feed name", feed_item.errors.on(:feed_name)
    end
  end

  test "legal feed names" do
    bad_feed_names = %w{ feed1 afeed a_feed a-feed a_long_feed_name }

    bad_feed_names.each do |feed_name|
      feed_item = FeedItem.new(:feed_name => feed_name,
        :title => "Sample title",
        :description => "Sample description")
      assert feed_item.valid?
    end
  end

  test "duplicate descriptions" do
    feed_item = FeedItem.new(:feed_name => 'feed_one',
      :title => 'feed one item four',
      :description => 'feed one item one')
    assert feed_item.valid?
    assert feed_item.save
  end

  test "duplicate titles in one feed" do
    feed_item = FeedItem.new(:feed_name => 'feed_one',
      :title => 'feed one item one',
      :description => 'new feed item one')
    assert !feed_item.valid?
  end

  test "duplicate titles in different feeds" do
    feed_item = FeedItem.new(:feed_name => 'feed_two',
      :title => 'feed one item one',
      :description => 'new feed one item one')
    assert feed_item.valid?
  end
end
