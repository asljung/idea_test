class OrganisationsController < ApplicationController
	before_action :signed_in_user

	def show
		@ideas = current_ideas.limit(5)
	end

end

