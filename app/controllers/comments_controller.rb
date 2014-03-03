class CommentsController < ApplicationController
	before_filter :get_idea
	before_action :signed_in_user, only: :create

	def index
	  @comments_all = @idea.comment_threads
	end

	def new
    @comment = Comment.new
  end

	def create
		@comment = Comment.new comment_params
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  @commentable = Comment.find_commentable(params[:comment][:commentable_type], params[:comment][:commentable_id])
	 	@comment.commentable = @commentable
    Rails.logger.debug("My object: #{@commentable.inspect}")
    @commentable.increment!(:comment_count)
	  @comment.user_id = @current_user.id
	  if @comment.save
	  	flash[:success] = 'Comment submitted.'
	    redirect_to @commentable
	  else
	    flash[:error] = 'Comment was not submitted.'
	    redirect_to @commentable
	  end
	end

	def get_idea
    @idea = Idea.find(params[:idea_id])
  end

	private
		def comment_params
    	params.require(:comment).permit(:title, :body, :commentable_type, :commentable_id)
  	end
end