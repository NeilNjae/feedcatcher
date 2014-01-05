class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :feed_name
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :feed_items, :feed_name
  end
end
