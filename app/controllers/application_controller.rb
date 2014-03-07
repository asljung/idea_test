class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

private
  def load_organisation
    unless Organisation.find_by_subdomain(request.subdomain).blank?
      @organisation = Organisation.find_by_subdomain!(request.subdomain)
    else
      redirect_to root_url(subdomain: nil)
    end
  end
end
