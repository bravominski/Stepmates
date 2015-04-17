class Patient < ActiveRecord::Base

	def self.search(search)
  		if search
    		where("name LIKE ?", "%#{search}%")
  		else
    		Patient.all
    	end
    end
end

