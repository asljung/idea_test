class Area < ActiveRecord::Base
	has_many :ideas
	validates :title, presence: true, length: { maximum: 80 }
	validates :description, presence: true, length: { maximum: 1000 }
end
