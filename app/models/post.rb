class Post < ApplicationRecord
  validates_presence_of :date, :rationale
  belongs_to :user
  enum status: { submitted: 0, approved: 1, rejected: 2 }

  scope :posts_by, ->(user) { where(user_id: user.id) }
end
