class Organisation < ActiveRecord::Base
	has_many :areas
	has_many :users
	validates :name, presence: true, length: { maximum: 80 }
	validates :description, length: { maximum: 1000 }
	validates :area_description, length: { maximum: 1000 }
end
