class Idea < ActiveRecord::Base
	belongs_to :user
	belongs_to :area
	acts_as_commentable
	has_many :comments
	has_many :uploads, :dependent => :destroy
	accepts_nested_attributes_for :uploads, :allow_destroy => true
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: { maximum: 80 }
	validates :content, presence: true, length: { maximum: 2000 }
	validates :user_id, presence: true

	def self.search(search)
    if search
      where("ideas.title LIKE ? OR ideas.content LIKE ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
