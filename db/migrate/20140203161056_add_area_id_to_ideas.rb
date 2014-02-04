class AddAreaIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :area_id, :integer
    add_index :ideas, :area_id
  end
end
