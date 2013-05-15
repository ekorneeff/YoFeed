class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :token
      t.string :secret
      t.string :uid
      t.string :name
      t.integer :user_id
      t.string :provider

      t.timestamps
    end
  end
end
