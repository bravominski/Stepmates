class SessionsController < ApplicationController
  
  # Data inputting to create a new session for user(not saved yet).
  def new
    if User.find_by(id: session[:user_id]) != nil 
      redirect_to '/patients'
    end
  end 

  # With given input data from user(this case, user email and password) create and start a new session
  # Checks if there exists a user account corresponding to input and check email/password combination.
  def create
  	 user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/patients'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # Distory currently running user session and go back to login page
  def destroy
    log_out
    redirect_to root_url
  end
end
