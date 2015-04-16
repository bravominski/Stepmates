class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :email]

  # GET /patients
  # GET /patients.json
  # Show the entire list of Patient database
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  # GET /patients/1.json
  # Show specific object in Patient database
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

    ###### get data with access token ######
    access_token = @patient.access_token

    uri = URI.parse("https://api.moves-app.com/api/1.1/user/activities/daily/" +
      year_string + month_string + day_string + "?" + "access_token=" + access_token)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    @body = response.body

    ########################################
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

    respond_to do |format|
      if @patient.save
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
