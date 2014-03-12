class AddAttachmentThumbnailToAreas < ActiveRecord::Migration
  def self.up
    change_table :areas do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :areas, :thumbnail
  end
end
