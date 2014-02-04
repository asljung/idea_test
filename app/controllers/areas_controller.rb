class AreasController < ApplicationController
	before_action :signed_in_user

	def show
		@area = Area.find(params[:id])
		@ideas_all = @area.ideas 
	end

	def index
		@areas = Area.all
	end

end

