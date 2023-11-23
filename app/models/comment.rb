class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  scope :for_post, ->(post_id) { where(post_id: post_id) }
end
