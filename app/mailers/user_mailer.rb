class UserMailer < ApplicationMailer
	default from: 'rextardus@gmail.com'

	def welcome_email(user)
		@user = user
		@url = 'https://arcane-garden-4526.herokuapp.com/login'
		mail(to: @user.email, subject: "Welcome to our app!")
	end
end
