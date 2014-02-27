class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :idea_id

      t.timestamps
    enduser_id
    add_index :votes, :user_id
    add_index :votes, :idea_id
    add_index :votes, [:user_id, :idea_id], unique: true
  end
end
