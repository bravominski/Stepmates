require 'uri'
require 'net/http'
require 'net/https'

class MovesController < ApplicationController
	def getAuth
		redirect_to "https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl&scope=activity"
	end

	def receiveAuth
		@code = params[:code]

		uri = URI.parse("https://api.moves-app.com/oauth/v1/access_token?grant_type=" + 
			"authorization_code&code=" + code + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" + 
			"&client_secret=8x0b3qdW0vlymVotk5njmJnaSX2Qd9veXP970M5nrTZjHGdKGb95V64x10eW51DW&")
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
		#req['foo'] = 'bar'
		#req.body = "[ #{@toSend} ]"
		@res = https.request(req)
		

	end
end
