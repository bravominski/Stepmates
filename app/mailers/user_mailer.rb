class UserMailer < ApplicationMailer
	default from: 'welcome@stepmates.com'

	def welcome_email(user)
		@user = user
		@url = 'https://arcane-garden-4526.herokuapp.com/login'
		mail(to: @user.email, subject: "Welcome to our app!")
	end

	def passwrod_reset(user)
		@suer = user
		mail :to => user.email, :subject => "Here is your password!"
	end
end
