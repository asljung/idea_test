class AddVoteCountToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :vote_count, :integer
  end
end
