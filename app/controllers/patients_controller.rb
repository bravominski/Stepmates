require 'json'

class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :custom_email, :send_email]

  # GET /patients
  # GET /patients.json
  # Show the entire list of Patient database
  def index
    if params[:search]
      @patients = Patient.search(params[:search])
    else
      @patients = Patient.all
    end
  end


  def show

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


    access_token = @patient.access_token

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
        "grant_type=refresh_token&refresh_token=" + @patient.refresh_token + "&client_id=rk4jNeuJ054WTTlYV9l4QF9dYsGdFwdl" +
        "&client_secret=gE8sVNO5MQNTX_tKLMoYtfBSu4QVeOco5x9FW_FSq38v0V14K_OKRTo69TSUpvhW")

      @res = http.request(request)
      @res = @res.body

      ###### renew the access_token and refresh_token in the database ######
      @patient.access_token = JSON.parse(@res)["access_token"]
      @patient.refresh_token = JSON.parse(@res)["refresh_token"]
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
    @parsed_data = JSON.parse(@body)

  end



  # GET /patients/new
  # Start the process of registering new patient(not saved yet) -> basically the new patient page
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  # Start the process of editting information regarding specific patient object(not saved yet) -> edit patient page
  def edit
  end

  # POST /patients
  # POST /patients.json
  # Same as using "new" first and then "save". With given information, new patient is registered in the database
  def create
    @patient = Patient.new(patient_params)
    @user = current_user
    respond_to do |format|
      if @patient.save
        PatientMailer.welcome_email(@user, @patient).deliver_now
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  # Same as using "edit" first and then "save". Modifying the specific patient data with given input.
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  # Removing specific patient data from the database.
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def custom_email
  end

  def send_email
      @user = current_user
      message = params[:custom_email][:message]
      PatientMailer.custom_email(@user, @patient, message).deliver_now
      redirect_to @patient, :notice => "Email sent!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Called before specific activities that deals with specific patient's data(show, update, destroy, edit)
    # to set which patient's data to run the functionality with.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # For creating and updating patient data, retrieves input data from user.
    def patient_params
      params.require(:patient).permit(:name, :mrn, :dob, :email, :access_token, :refresh_token)
    end
end
