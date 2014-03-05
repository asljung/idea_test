class AreasController < ApplicationController
	before_action :signed_in_user
	before_action :save_area

	def show
		@area = Area.find(params[:id])
		@ideas_all = @area.ideas 
		@vote_link = []
    @vote_class = []
    @images = []
    @ideas_all.each { |idea|
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

	def index
		@areas = Area.all
	end

	private
		def save_area
			session[:area_id] = params[:id]
		end

end

