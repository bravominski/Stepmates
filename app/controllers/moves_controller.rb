require 'uri'
require 'json'
require 'net/http'
require 'net/https'

class MovesController < ApplicationController
	##### we must get authorization code from moves api #####
	def getAuth
		redirect_to "https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=" +
		 "rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl&scope=activity"
	end

	##### moves api redirects to this method, so this is our endpoint that receives a message
	##### from moves api
	def receiveAuth
		##### Get the authorization code that has been sent back from moves api
		@code = params[:code]
		
		##### make a post request to moves api using the authorization code #####
		uri = URI.parse("https://api.moves-app.com")

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new("/oauth/v1/access_token?" + 
			"grant_type=authorization_code&code=" + @code + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" +
			"&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW")

		@res = http.request(request)
		@res = @res.body

		##### extract the tokens from the returned value #####
		##### these tokens are saved as instance variables #####
		@access_token = JSON.parse(@res)["access_token"]
		@refresh_token = JSON.parse(@res)["refresh_token"]
		
		render 'patients/new'
	end

	##### For showing data of all patients #####
	def showall
		@patients = Patient.all
		render 'patients/showall'
	end
end
