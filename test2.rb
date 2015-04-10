require 'json'
test_string = '[{"date":"20150401","summary":[{"activity":"walking","group":"walking","duration":6681.0,"distance":6969.0,"steps":9444}],"segments":[{"type":"move","startTime":"20150401T104233-0400","endTime":"20150401T105140-0400","activities":[{"activity":"walking","group":"walking","manual":false,"startTime":"20150401T104233-0400","endTime":"20150401T105139-0400","duration":546.0,"distance":829.0,"steps":1046}],"lastUpdate":"20150401T154824Z"},{"type":"move","startTime":"20150401T115554-0400","endTime":"20150401T121155-0400","activities":[{"activity":"walking","group":"walking","manual":false,"startTime":"20150401T115554-0400","endTime":"20150401T121155-0400","duration":961.0,"distance":645.0,"steps":1290}],"lastUpdate":"20150401T172140Z"},{"type":"place","startTime":"20150401T121155-0400","endTime":"20150401T122233-0400","activities":[{"activity":"walking","group":"walking","manual":false,"startTime":"20150401T121313-0400","endTime":"20150401T121613-0400","duration":180.0,"distance":135.0,"steps":143}],"lastUpdate":"20150401T172140Z"},{"type":"move","startTime":"20150401T122233-0400","endTime":"20150401T122718-0400","activities":[{"activity":"walking","group":"walking","manual":false,"startTime":"20150401T122233-0400","endTime":"20150401T122718-0400","duration":285.0,"distance":200.0,"steps":343}],"lastUpdate":"20150401T172140Z"},{"type":"place","startTime":"20150401T122718-0400","endTime":"20150401T125259-0400","activities":[{"activity":"walking","group":"walking","manual":false,"startTime":"20150401T124920-0400","endTime":"20150401T124950-0400","duration":30.0,"distance":26.0,"steps":51}],"lastUpdate":"20150401T185239Z"}]}]'
test_hash = JSON.parse(test_string)
puts "date: " + test_hash[0]["date"]
puts
puts test_hash[0]["summary"]
puts
test_hash[0]["segments"].length.times do |i|
	puts test_hash[0]["segments"][i]
	puts
end
