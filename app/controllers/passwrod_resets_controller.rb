class PasswrodResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	UserMailer.passwrod_reset(user).deliver if user
  	redirect_to root_url, :notice => "Email sent with your password!"
  end
end
