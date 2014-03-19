class CommentsController < ApplicationController
	before_filter :get_idea
	before_action :signed_in_user, only: :create

	def index
	  @comments = @idea.comment_threads.paginate(:page => params[:page], :order => 'created_at DESC')
	end

	def new
    @comment = Comment.new
  end

	def create
		@comment = Comment.new comment_params
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  @commentable = Comment.find_commentable(params[:comment][:commentable_type], params[:comment][:commentable_id])
	 	@comment.commentable = @commentable
	  @comment.user_id = @current_user.id
    @idea = @commentable
	  if @comment.save
      @commentable.increment!(:comment_count)
     end
    respond_to do |format|
      format.html {
        redirect_to @commentable
      }
      format.js
    end
	end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @comment.commentable.decrement!(:comment_count)
    end
    redirect_to(:back)
  end

	def get_idea
    @idea = Idea.find(params[:idea_id])
  end

	private
		def comment_params
    	params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  	end
end