class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :announce
      t.string :author
      t.string :avatar_url
      t.string :cover_url
      t.string :url
      t.text :body
      t.integer :feed_id
      t.string :time_marker
      t.string :state

      t.timestamps
    end
  end
end
