require 'open-uri'
require 'json'

value = '{"val":"test","val1":"test1","val2":"test2"}'
test = JSON.parse(value)["val"]
puts test
