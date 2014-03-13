class AreasController < ApplicationController
	before_action :signed_in_user
	before_action :save_area

	def show
		@area = current_areas.find(params[:id])
		@ideas = @area.ideas.recent.paginate(:page => params[:page])
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

	def index
		@areas = current_areas
	end

  def create
    @area = current_org.areas.build(area_params)
    @area.save
  end

  def update
    @area.update_attributes(area_params)
  end

	private
		def save_area
			session[:area_id] = params[:id]
		end

    def area_params
      params.require(:area).permit(:title, :description, :thumbnail, :_destroy)
    end

end

