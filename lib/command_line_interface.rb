require_relative '../app/models/actor.rb'
require_relative '../app/models/movie.rb'
require_relative '../app/models/car.rb'

def welcome
puts "Welcome to James-Bond-Car-Pedia!"  
sleep 1
puts "The database that includes 23 films, 6 actors who have played James Bond, and 12 cars."
sleep 1
end

def menu
puts "Menu: "
puts "1 - list actors" 
puts "2 - list movies"
puts "3 - list cars"
input = gets.chomp
	if input == 1.to_s
		actor_menu
	elsif input == 2.to_s
		movie_menu
	elsif input == 3.to_s
		car_menu
	else 
		puts "invalid input"
		menu
	end
end

def actor_menu
	i = 1
	actor_array.each do |actor|
	puts "#{i} - #{actor}"
	i += 1
	end
	puts "Enter an actor for more info or b for back"
	input = gets.chomp
	if input == "b"
		menu
	elsif input.to_i <= 0 || input.to_i > actor_array.length
		puts "invald input"
		actor_menu
	else
		actor_menu_specifics(input.to_i - 1)
	end
end

	
	def actor_match(person)
	#returns the actor object of a given actor name
		actor_id = nil 
		Actor.all.find do |actor_instance|
			if actor_instance["name"] == person
			actor_id = actor_instance.id
			end
		end
	end

def actor_menu_specifics(argument)
	puts "#{actor_array[argument]}! Love that guy."
	puts "Enter number for: "
	puts "1 - actor's cars" 
	puts "2 - actor's movies"
	puts "3 - actor's highest rated movie and the car in it"
	puts "4 - back to Actors menu"
	puts "5 - back to main menu"
	input = gets.chomp 
	if input == 4.to_s
		actor_menu
	elsif input == 5.to_s
		menu
	elsif input == 1.to_s
		actor_match(actor_array[argument]).cars.each do |car|
			puts car.name
		end
	elsif input == 2.to_s
		actor_match(actor_array[argument]).movies.each do |movie|
			puts movie.title
		end
	elsif input == 3.to_s
		a = actor_match(actor_array[argument]).movies.max_by do |movie|
			movie.rotten_tomatoes_critic_score
		end
		puts "Title: #{a.title} (#{a.rotten_tomatoes_critic_score} % on Rotten Tomatoes)"
		puts "Car: #{a.car.name}"
	end
end
	

def movie_menu
	i = 1
	movie_array.each do |movie|
	puts "#{i} - #{movie}"
	i += 1
	end
	puts "Enter a movie for more info or b for back"
	input = gets.chomp
	if input == "b"
		menu
	elsif input.to_i <= 0 || input.to_i > movie_array.length
		puts "invald input"
		movie_menu
	else
		movie_menu_specifics(input.to_i - 1)
	end
end

def movie_menu_specifics(argument)
	puts "#{movie_array[argument]}! Love that film!"
	puts "Enter number for: "
	puts "1 - James Bond"
	puts "2 - Box Office Gross"
	puts "3 - Car featured"
	puts "4 - Rotten Tomatoes Scores"
	puts "5 - Back to movies menu"
	puts "6 - back to main menu"
	input = gets.chomp 
	if input == 5.to_s
		movie_menu
	elsif input == 6.to_s
		menu
	elsif input == 1.to_s
		puts movie_match(movie_array[argument]).actor.name
		
	elsif input == 2.to_s
		puts "Box Office Actual Gross: "
		g = movie_match(movie_array[argument]).box_office_actual.to_i * 1000000
		puts g
		puts "Box Office Adjusted for Inflation Gross: "
		h = movie_match(movie_array[argument]).box_office_adjusted.to_i * 1000000
		puts h
	elsif input == 3.to_s
		puts movie_match(movie_array[argument]).car.name
	elsif input == 4.to_s
		puts "Rotten Tomatoes Critic Score: "
		puts "#{movie_match(movie_array[argument]).rotten_tomatoes_critic_score} % on Rotten Tomatoes"
		puts "Rotten Tomatoes Audience Score: "
		puts "#{movie_match(movie_array[argument]).rotten_tomatoes_audience_score} % on Rotten Tomatoes"
	end
end

	def movie_match(film)
	#returns the movie object of a given movie title
		Movie.all.find do |movie_instance|
			movie_instance["title"] == film
		end
	end

	def car_menu
		i = 1
		car_array.each do |car|
		puts "#{i} - #{car}"
		i += 1
		end
		puts "Enter a car for more info or b for back"	
		input = gets.chomp
		if input == "b"
			menu
		elsif input.to_i <= 0 || input.to_i > car_array.length
			puts "invald input"
			car_menu
		else
			car_menu_specifics(input.to_i - 1)
		end
	end

	def car_menu_specifics(argument)
	puts "#{car_array[argument]}! Love that car!!"
	puts "Enter number for: "
	puts "1 - Which movies it appears in"
	puts "2 - Which actors drove it"
	puts "3 - Highest rated movie it appeared in"
	puts "4 - Back to cars menu"
	puts "5 - back to main menu"
	input = gets.chomp 
	if input == 4.to_s
		car_menu
	elsif input == 5.to_s
		menu
	elsif input == 1.to_s
		car_match(car_array[argument]).movies.each do |movie|
			puts movie.title
		end
	elsif input == 2.to_s
		array = []
		car_match(car_array[argument]).actors.each do |actor|
			array << actor.name
		end
		array_2 = array.uniq
		puts array_2
		
	end
	end

	def car_match(car_name)
	#returns the actor object of a given actor name
		car_id = nil 
		Car.all.find do |car_instance|
			if car_instance["name"] == car_name
			car_id = car_instance.id
			end
		end
	end


	