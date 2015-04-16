class PatientMailer < ApplicationMailer
	default from: @user.email

	def welcome_email(patient)
		email = patient.email
		mail(:to email, subject:"From your doctor")
	end
end
