class Actor < ActiveRecord::Base
	has_many :movies
	has_many :cars, through: :movies

	def actors_cars(actor)
		
	end

	# puts "1 - actor's cars" 
	# puts "2 - actor's movies"
	# puts "3 - actor's highest rated movie and the car in it"

end


 