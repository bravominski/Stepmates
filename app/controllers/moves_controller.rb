require 'uri'
require 'net/http'
require 'net/https'

class MovesController < ApplicationController
	def getAuth
		redirect_to "https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=' +
		 'rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl&scope=activity"
	end

	def receiveAuth
		@code = params[:code]
		
	end

	def helper
		uri = URI.parse('https://api.moves-app.com/oauth/v1/access_token?' + 
			'grant_type=authorization_code&code=' + @code + '&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl' +
			'&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW')

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new('https://api.moves-app.com/oauth/v1/access_token?' + 
			'grant_type=authorization_code&code=' + @code + '&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl' +
			'&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW',
			 {'Content-Type' =>'application/json'})

		@res = http.request(request)
	end

end
