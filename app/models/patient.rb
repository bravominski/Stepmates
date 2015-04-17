class Patient < ActiveRecord::Base

	validates_uniqueness_of :name, :case_sensitive => false

	def self.search(search)
  		if search
    		where("name LIKE ?", "%#{search}%")
  		else
    		Patient.all
    	end
    end
end

