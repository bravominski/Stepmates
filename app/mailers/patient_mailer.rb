class PatientMailer < ApplicationMailer

	def welcome_email(user, patient)
		@patient = patient
		@user = user
		mail(from: @user.email, to: @patient.email, subject:"From your doctor")
	end

	def custom_email(user, patient, message)
		@patient = patient
		@user = user
		@message = message
		mail(from: @user.email, to: @patient.email, subject:"From your doctor")
	end

end
