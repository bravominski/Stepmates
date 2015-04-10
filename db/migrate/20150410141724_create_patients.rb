class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :mrn
      t.string :dob
      t.string :email
      t.string :access_token
      t.string :refresh_token

      t.timestamps null: false
    end
  end
end
