class Area < ActiveRecord::Base
	has_many :ideas
	belongs_to :organisation
	validates :title, presence: true, length: { maximum: 80 }
	validates :description, presence: true, length: { maximum: 1000 }
end
