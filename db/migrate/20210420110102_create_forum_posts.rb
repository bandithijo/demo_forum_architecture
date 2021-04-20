class CreateForumPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_posts do |t|
      t.references :forum_thread, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
