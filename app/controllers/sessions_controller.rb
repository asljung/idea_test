class SessionsController < ApplicationController
	before_action :load_organisation, only: [:new]

  def new
  end

  def create
  	user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in(user, nil, nil)
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url(subdomain: nil)
  end
end
