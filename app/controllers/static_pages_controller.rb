class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      # Following line is for the idea_form partial
      @idea  = current_user.ideas.build
      @ideas = current_ideas.limit(5)
      @feed_items = current_user.feed.paginate(page: params[:page])
      @vote_link = []
      @vote_class = []
      @ideas.each { |idea|
        if idea.voted?(current_user) 
          @link = user_unvote_path(:id => current_user.id, :idea_id => idea.id)
          @class = "voted"
        else
          @link = user_vote_path(:id => current_user.id, :idea_id => idea.id)
          @class = "unvoted"
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
