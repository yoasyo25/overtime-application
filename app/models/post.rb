class Post < ApplicationRecord
  validates_presence_of :date, :rationale
  belongs_to :user
  enum status: { submitted: 0, approved: 1, rejected: 2 }
end
