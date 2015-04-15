module SessionsHelper

  # Logs in the given user, set session's user id as currently logging-in user's
  def log_in(user)
    session[:user_id] = user.id
  end

  # If there is a user logged in, return it, else return nil.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Destroy session and set current_user to nil.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
