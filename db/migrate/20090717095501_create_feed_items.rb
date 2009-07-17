class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string :feed_name
      t.string :title
      t.text :description

      t.timestamps
    end

    add_index :feed_items, :feed_name
  end

  def self.down
    remove_index :feed_items, :feed_name

    drop_table :feed_items
  end
end
