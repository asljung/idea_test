class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      # Following line is for the idea_form partial
      @idea  = current_user.ideas.build
      limit = 10
      ideas = current_ideas.joins(:user).select('ideas.*, ideas.created_at as activity_date, users.name').order('activity_date DESC').limit(limit)
      comments = current_ideas.joins("INNER JOIN comments ON commentable_id = ideas.id INNER JOIN users ON users.id = comments.user_id").select("ideas.*, comments.created_at as activity_date, comments.id as comment, users.name").where('comments.commentable_type' => 'Idea').group('ideas.id').order('activity_date DESC').limit(limit)
      @combined_sorted = (ideas + comments).sort_by(&:activity_date).reverse.first(limit)
      @ideas = @combined_sorted.uniq { |h| h[:id] }

      @vote_link = []
      @vote_class = []
      @images = []
      @ideas.each { |idea|
        if idea.voted?(current_user) 
          @link = user_unvote_path(:id => current_user.id, :idea_id => idea.id)
          @class = "voted"
        else
          @link = user_vote_path(:id => current_user.id, :idea_id => idea.id)
          @class = "unvoted"
        end
        if idea.uploads.first
          @images[idea.id] = idea.uploads.first.uploaded_file(:thumb_list)
        end
        @vote_link[idea.id] = @link
        @vote_class[idea.id] = @class
      }
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
