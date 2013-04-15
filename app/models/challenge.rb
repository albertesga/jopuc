class Challenge < ActiveRecord::Base
  attr_accessible :begin, :content, :end, :reward
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  default_scope order: 'challenges.created_at DESC'
end
