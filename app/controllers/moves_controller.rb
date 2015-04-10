require 'uri'
require 'net/http'
require 'net/https'

class MovesController < ApplicationController
	def getAuth
		redirect_to "https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl&scope=activity"
	end

	def receiveAuth
		@code = params[:code]
		
		logger.info 'before parsing url'

		uri = URI.parse("https://api.moves-app.com/oauth/v1/access_token?grant_type=" + 
			"authorization_code&code=" + code + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" + 
			"&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW")
		
		logger.info 'after parsing url'

		https = Net::HTTP.new(uri.host,uri.port)
		
		logger.info 'after new http req'
		https.use_ssl = true

		req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
		logger.info 'create a post req'

		@res = https.request(req)
		logger.info 'send post req'

	end

end
