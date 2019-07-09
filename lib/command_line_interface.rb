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

def actor_menu_specifics(input)
	puts "#{actor_array[input]}! Love that guy."
	puts "Enter number for: "
	puts "1 - actor's cars" 
	puts "2 - actor's movies"
	puts "3 - actor's highest rated movie and the car in it"
	puts "4 - back to Actors menu"
	puts "5 - back to main menu"
end

def actor_match(person)
		actor_id = nil 
		Actor.all.find do |actor_instance|
			if actor_instance["name"] == person
			actor_id = actor_instance.id
			end
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
	end
end

	

# def get_character_from_user
# puts "please enter a character name"
# # use gets to capture the user's input. This method should return that input, downcased.
# input = gets.chomp
# input.downcase

# end

# def here
# puts "Here are that character's movies:"
# end