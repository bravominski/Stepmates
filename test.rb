require 'net/http'

require "net/https"
require "uri"

uri = URI.parse("https://api.moves-app.com/api/1.1/user/activities/daily/20150401?access_token=e7GB8VDBNA62w4d0j6XalVQls62CxLvWueP2oO2mhjMwzVeqp9U5zLJ8Lc0ZEjAN")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
puts response.body
