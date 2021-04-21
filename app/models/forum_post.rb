class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user

  validates :body, presence: true

  def send_notifications!
    # `TODO`:
    # 1. Get all the unique users in this Thread
    users = forum_thread.users.uniq - [user]
    # 2. Send an email to each of those user
    users.each do |user|
      NotificationMailer.forum_post_notification(user, self).deliver_later
    end
  end
end

# == Schema Information
#
# Table name: forum_posts
#
#  id              :integer          not null, primary key
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forum_thread_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_forum_posts_on_forum_thread_id  (forum_thread_id)
#  index_forum_posts_on_user_id          (user_id)
#
# Foreign Keys
#
#  forum_thread_id  (forum_thread_id => forum_threads.id)
#  user_id          (user_id => users.id)
#
