class IdeasController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :edit, :update]
	before_action :correct_user,   only: [:destroy, :edit, :update]


  def show
    @idea = Idea.find(params[:id])
  end

  def create
  	@idea = current_user.ideas.build(idea_params)
    if @idea.save
      flash[:success] = "Idea submitted!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    @idea = Idea.new
  end

  def edit
    @idea = Idea.find(params[:id])
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
      params.require(:idea).permit(:content, :title)
    end

    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
