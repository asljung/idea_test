include ApplicationHelper

def sign_in(user, options={})
	if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
	  visit signin_url(:subdomain => 'test')
	  fill_in "email",    with: user.email
	  fill_in "password", with: user.password
	  click_button "Sign in"
	end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end