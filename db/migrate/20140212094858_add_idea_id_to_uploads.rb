class AddIdeaIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :idea_id, :integer
    add_index :uploads, :idea_id
  end
end
