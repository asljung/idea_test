class AddCommentCountToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :comment_count, :integer
  end
end
