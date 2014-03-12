class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :load_organisation, only: [:create, :new]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :vote_params,    only: [:vote, :unvote]

  def index
    @users = current_org.users.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show
    @user = current_org.users.find(params[:id])
    @ideas = @user.ideas.paginate(page: params[:page], :order => 'created_at DESC')
  end

  def new
  	@user = User.new
  end

  def create
		@user = User.new(user_params)     
    @user.organisation_id = @organisation.id
    logger.debug @user
		if @user.save
      sign_in @user
			flash[:success] = "Welcome to the IdeaCloud!"
     	redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_user.admin?
      @user.update(user_params_admin)
    elsif @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user  
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def vote
    @user.vote!(@idea)
  end

  def unvote 
    @user.unvote!(@idea)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def user_params_admin
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :admin)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def vote_params
      @user = User.find(params[:id])
      @idea = Idea.find(params[:idea_id])
    end
end
