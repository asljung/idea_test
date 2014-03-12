class Area < ActiveRecord::Base
  has_attached_file :thumbnail, :styles => { :medium => "600x400#", :thumb => "150x100#" }
	has_many :ideas
	belongs_to :organisation
	validates :title, presence: true, length: { maximum: 200 }
	validates :description, presence: true, length: { maximum: 1000 }
  attr_accessor :_destroy

  before_save :delete_thumbnail, if: ->{ _destroy == '1' && !thumbnail_updated_at_changed? }

  private
 
  def delete_thumbnail
    self.thumbnail = nil
  end
end
