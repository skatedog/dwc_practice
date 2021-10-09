class Relationship < ApplicationRecord
  validates :follower_id, uniqueness: { scope: :followed_id }

  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  counter_culture :follower, column_name: 'following_count'
  counter_culture :followed, column_name: 'followers_count'
end
