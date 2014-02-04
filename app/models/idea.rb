class Idea < ActiveRecord::Base
	belongs_to :user
	belongs_to :area
	acts_as_commentable
	has_many :comments
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: { maximum: 80 }
	validates :content, presence: true, length: { maximum: 2000 }
	validates :user_id, presence: true
end
