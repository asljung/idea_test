class AreasController < ApplicationController
	before_action :signed_in_user
	before_action :save_area

	def show
		@area = Area.find(params[:id])
		@ideas_all = @area.ideas 
	end

	def index
		@areas = Area.all
	end

	private
		def save_area
			session[:area_id] = params[:id]
		end

end

