class PasswrodResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_passwrod_reset if user
  	redirect_to root_url, :notic => "Email sent with your password!"
  end
end
