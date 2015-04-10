require 'open-uri'

client_id = "rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl"
client_secret = ""

url = URI.parse('https://api.moves-app.com/oauth/v1/authorize?response_type=code&client_id=' + client_id + '&scope=activity').read
puts url 

array = url.split('digitgroup')

first_code = array[1][2...6]
second_code = array[2][2...6]

puts first_code 
puts second_code

