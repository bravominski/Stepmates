class PatientMailer < ApplicationMailer
	default from: @user.email

	def welcome_email(patient)
		@patient = patient
		mail(:to @patient.email, subject:"From your doctor")
	end
end
