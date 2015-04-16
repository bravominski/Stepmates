class Patient < ActiveRecord::Base

	def self.search(search)
  		if search
    		find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  		else
    		Patient.all
    	end
    end
end

