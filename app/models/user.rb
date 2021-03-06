class User < ActiveRecord::Base
  belongs_to :organisation
  has_many :ideas
  has_many :votes
  has_many :voted_ideas, through: :votes, source: :idea, :order => 'created_at'
	before_save { self.email = email.downcase }
  before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  															uniqueness: { case_sensitive: false }
  has_secure_password 
  validates :password, length: { minimum: 6 }, on: :create

  scope :not_active, where(active: false)


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def vote!(idea)
    votes.create!(idea_id: idea.id)
    idea.increment!(:vote_count)
  end

  def unvote!(idea)
    votes.find_by(idea_id: idea.id).destroy
    idea.decrement!(:vote_count)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
