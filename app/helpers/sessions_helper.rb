module SessionsHelper
	def sign_in(user, remember, domain)
    remember_token = User.new_remember_token
    if domain.nil?
      cookie_value = remember_token
    else
      cookie_value = { value: remember_token, domain: domain }
    end
    logger.debug "Cookie_value: #{cookie_value.inspect}"
    cookies.permanent[:remember_token] = cookie_value
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    logger.debug "Cookie remember_token: #{cookies[:remember_token].inspect}"
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    logger.debug "Cookie current_user remember_token: #{cookies[:remember_token].inspect}"
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You are not an admin user." unless current_user.try(:admin?)
  end

  def admin?
    current_user.try(:admin?)
  end

  def current_org
    @current_org = Organisation.find(current_user.organisation_id)
  end

  def current_areas
    @current_areas = current_org.areas
  end

  def current_ideas 
    @current_ideas = Idea.joins(area: :organisation).where(organisations: {id: current_org.id})
  end

  def current_comments
    @current_comments = Comment.joins("INNER JOIN ideas ON ideas.id = commentable_id INNER JOIN areas ON areas.id = ideas.area_id INNER JOIN organisations ON organisations.id = areas.organisation_id").where(organisations: {id: current_org.id}).select("comments.*")
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

	def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
end
