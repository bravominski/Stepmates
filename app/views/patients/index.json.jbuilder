json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :mrn, :dob, :email, :access_token, :refresh_token
  json.url patient_url(patient, format: :json)
end
