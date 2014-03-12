class Idea < ActiveRecord::Base
	belongs_to :user
	belongs_to :area
	acts_as_commentable
	has_many :comments
	has_many :uploads, :dependent => :destroy
	accepts_nested_attributes_for :uploads, :allow_destroy => true
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
	validates :title, presence: true, length: { maximum: 200 }
	validates :content, presence: true, length: { maximum: 5000 }
	validates :user_id, presence: true

	self.per_page = 10

	def self.search(search)
    if search
      where("ideas.title LIKE ? OR ideas.content LIKE ?", "%#{search}%", "%#{search}%")
    else
      self.all
    end
  end

  def voted?(user)
    votes.find_by(user_id: user.id)
  end
end
