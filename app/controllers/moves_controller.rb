require 'uri'
require 'json'
require 'net/http'
require 'net/https'

class MovesController < ApplicationController
	def getAuth
		redirect_to "https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=" +
		 "rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl&scope=activity"
	end

	def receiveAuth
		@code = params[:code]
		
		uri = URI.parse("https://api.moves-app.com")

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new("/oauth/v1/access_token?" + 
			"grant_type=authorization_code&code=" + @code + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" +
			"&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW")

		@res = http.request(request)
		@res = @res.body

		@access_token = JSON.parse(@res)["access_token"]
		@refresh_token = JSON.parse(@res)["refresh_token"]

	end

	def getData
		access_token = params[:access_token]

		uri = URI.parse("https://api.moves-app.com/api/1.1/user/activities/daily/20150401?" + 
			"access_token=" + access_token)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)

		@body = response.body

	end

end
