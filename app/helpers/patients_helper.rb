module PatientsHelper

  # GET /patients/1
  # GET /patients/1.json
  # Show specific object in Patient database
  def showData(patient)

    ##### set up time #####
    time = Time.new
    year = time.year
    month = time.month
    day = time.day

    year_string = year.to_s
    if month < 10
      month_string = "0" + month.to_s
    else
      month_string = month.to_s
    end

    if day < 10
      day_string = "0" + day.to_s
    else
      day_string = day.to_s
    end


    access_token = patient.access_token

    uri = URI.parse("https://api.moves-app.com/oauth/v1/tokeninfo?" +
     "access_token=" + access_token)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    ###### this is our data that we received ######
    body = response.body
    validation_response = JSON.parse(body)


    if validation_response["error"] != nil
      ###### make a post request to the moves api endpoint for refresh tokens  ######
      uri = URI.parse("https://api.moves-app.com")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new("/oauth/v1/access_token?" + 
        "grant_type=refresh_token&refresh_token=" + patient.refresh_token + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" +
        "&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW")

      @res = http.request(request)
      @res = @res.body

      ###### renew the access_token and refresh_token in the database ######
      patient.access_token = JSON.parse(@res)["access_token"]
      patient.refresh_token = JSON.parse(@res)["refresh_token"]
    end

    ###### get data with access token ######
    uri = URI.parse("https://api.moves-app.com/api/1.1/user/activities/daily/" +
      year_string + month_string + "?" + "access_token=" + access_token)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    ###### this is our data that we received ######
    @body = response.body
    parsed_data = JSON.parse(@body)
    return parsed_data
  end
end
