class IdeasController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user,   only: [:destroy, :edit, :update]
  before_action :current_areas, only: [:new, :create, :edit]
  before_action :selected_area, only: [:new, :create]

  def index
    @ideas = current_ideas.paginate(:page => params[:page])
    @search = params[:search]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @page = params[:page]
    @comments = @idea.comment_threads.paginate(:page => @page, :order => 'created_at DESC')
    @uploads = @idea.uploads
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  	@idea = current_user.ideas.build(idea_params)

    if @idea.save
      flash[:success] = "Idea submitted!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def new
    @idea = Idea.new
    @area_sel = Area.find(@area_id)
  end

  def edit
    @idea = Idea.find(params[:id])
    @area_sel = Area.find(@idea.area_id)
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
