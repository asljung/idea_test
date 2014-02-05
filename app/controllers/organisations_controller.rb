class OrganisationsController < ApplicationController
	before_action :signed_in_user

	def show
		@org = Organisation.find(params[:id])
		@ideas = Idea.joins(area: :organisation).where(organisations: {id: @org.id}).limit(5)
	end

end

