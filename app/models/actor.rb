class Actor < ActiveRecord::Base
	has_many :movies
	has_many :cars, through: :movies

	

end


 