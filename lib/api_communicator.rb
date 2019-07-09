require 'rest-client'
require 'json'
require 'pry'

	def bond_array
	  response_string = RestClient.get("http://dybushnell.com/bond/bonddata_edit.txt")
	  response_hash = JSON.parse(response_string)
	response_hash
	end

	def actor_array
		bond_array.map do |movie_instance|
		movie_instance["actor"]
		end.uniq
	end

	def create_actor
		actor_array.each do |actor|
			if Actor.all.length == 6
			nil
			else 
			Actor.create(name: actor)
			end
		end
	end

	def car_array
		bond_array.map do |movie_instance|
		movie_instance["car"]
		end.uniq
	end

 	def create_car
		car_array.each do |car|
			if Car.all.length == 12
				nil
			else
				Car.create(name: car)
			end
		end
	end

 	def create_movie
 		
 	end