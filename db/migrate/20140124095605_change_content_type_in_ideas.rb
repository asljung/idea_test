class ChangeContentTypeInIdeas < ActiveRecord::Migration
  def change
  	change_column :ideas, :content, :text
  end
end
