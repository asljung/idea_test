class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      # Following line is for the idea_form partial
      @idea  = current_user.ideas.build
      @ideas = current_ideas.limit(5)
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
