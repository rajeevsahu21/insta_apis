class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :for_post, ->(post_id) { where(post_id: post_id) }
end
