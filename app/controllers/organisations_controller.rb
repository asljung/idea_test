class OrganisationsController < ApplicationController
  before_action :load_organisation, only: [:show]
	before_action :signed_in_user, only: [:show]

	def show
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

  def new
    @org = Organisation.new
    @org.users.build
  end

  def create
    @org = Organisation.new(organisation_params)
    if @org.save
      @user = @org.users.first
      sign_in(@user, nil, "." + request.domain)
      flash[:notice] = "Organisation successfully created!"
      redirect_to root_url(subdomain: @org[:subdomain])
    else
      render :action => 'new'
    end
  end

  private

    def organisation_params
      params.require(:organisation).permit(:name, :description, :area_description, :subdomain, users_attributes: [:id, :name, :email, :password,
                                   :password_confirmation, :admin, :active])
    end

end

