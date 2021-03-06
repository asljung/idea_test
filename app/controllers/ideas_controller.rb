class IdeasController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user,   only: [:destroy, :edit, :update]
  before_action :current_areas, only: [:new, :create, :edit]
  before_action :selected_area, only: [:new, :create]

  def index
    if params[:sort] == "popular"
      @ideas = current_ideas.voted.paginate(:page => params[:page]).search(params[:params])
    elsif params[:sort] == "commented"
      @ideas = current_ideas.commented.paginate(:page => params[:page]).search(params[:params])
    else
      @ideas = current_ideas.recent.paginate(:page => params[:page]).search(params[:params])
    end

    @search = params[:search]
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

  def show
    @idea = current_ideas.find(params[:id])
    @comment = Comment.new
    @page = params[:page]
    @comments = @idea.comment_threads.paginate(:page => @page, :order => 'created_at DESC')
    @uploads = @idea.uploads
    if @idea.voted?(current_user) 
      @vote_link = user_unvote_path(:id => current_user.id, :idea_id => @idea.id)
      @vote_class = "voted"
    else
      @vote_link = user_vote_path(:id => current_user.id, :idea_id => @idea.id)
      @vote_class = "unvoted"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  	@idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = "Idea submitted!"
      redirect_to ideas_path()
    else
      render 'new'
    end
  end

  def new
    if current_areas.any?
      @area_sel = current_areas.find(@area_id)
      @idea = Idea.new
    else
      flash[:notice] = "No challenges. A challenge has to exist before ideas can be submitted"
      redirect_to root_path()
    end
  end

  def edit
    @idea = Idea.find(params[:id])
    @area_sel = current_areas.find(@idea.area_id)
  end

  def update
    if @idea.update_attributes(idea_params)
      flash[:success] = "Idea updated"
      redirect_to @idea  
    else
      render 'edit'
    end
  end

  def destroy
  	@idea.destroy
    redirect_to root_url
  end

  private

    def idea_params
      params.require(:idea).permit(:content, :title, :area_id)
    end

    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end

    def selected_area
      #get area_id from session if it is blank
      params[:area_id] ||= session[:area_id] 

      if params[:area_id]
        @area_id = params[:area_id]
      else
        @area_id = current_areas.first
      end
    end
end
