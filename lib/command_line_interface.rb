require_relative "../app/models/actor.rb"
require_relative "../app/models/movie.rb"
require_relative "../app/models/car.rb"

def welcome
  #sleep 1
  logo = Artii::Base.new :font => 'slant'
  puts logo.asciify('007')
  #sleep 1 
  puts "Welcome to James-Bond-Car-Pedia!"
  #sleep 1
  puts ""
  #sleep 1
  puts "The database that includes #{Movie.all.length} films, #{Actor.all.length} actors who have played James Bond, and #{Car.all.length} cars."
  #sleep 1
  puts ""
end

def menu
  puts "Menu: "
  puts "1 - list actors"
  puts "2 - list movies"
  puts "3 - list cars"
  puts "4 - quit"
  input = gets.chomp
  if input == 1.to_s
    actor_menu
  elsif input == 2.to_s
    movie_menu
  elsif input == 3.to_s
    car_menu
  elsif input == 4.to_s
    puts ""
    puts "Farewell!"
  elsif input == "007"
    puts "press y to create a new James Bond actor, car & movie."
    puts "press any other key to return to the main menu"
    input_2 = gets.chomp 
    if input_2 == "y"
      creation_menu
    else 
      menu
    end
  else
    puts "invalid input"
    puts ""
    menu
  end
end

def creation_menu
  puts "Enter an actor"
  input_actor = gets.chomp.rstrip
  this_actor = nil
    actor_object = Actor.all.find do |actor|
      if actor.name.downcase == input_actor.downcase
        actor
      
    this_actor = actor_object
    else 
      this_actor = Actor.create(name: input_actor)
    end
    end
  puts "Enter a car"
  input_car = gets.chomp.rstrip
  this_car = nil
    car_object = Car.all.find do |car|
      if car.name.downcase == input_car.downcase
        car
      
    this_car = car_object
    else 
      this_car = Car.create(name: input_car)
    end
  end

  puts "Enter a movie title"
  input_title = gets.chomp
binding.pry 
0
  # Movie.create(title: input_title, year: input_year, rotten_tomatoes_critic_score: input_rtcs, rotten_tomatoes_audience_score: input_rtas, box_office_actual: input_actual, box_office_adjusted: input_adjusted, actor_id: this_actor.id, car_id: this_car.id)
end

def actor_menu
  puts ""
  puts "**Actors**"
  puts ""
  i = 1
  actor_array.each do |actor|
    puts "#{i} - #{actor}"
    i += 1
  end
  puts ""
  puts "Enter an actor for more info or b for back"
  input = gets.chomp

  if input == "b"
    menu
  elsif input.to_i <= 0 || input.to_i > actor_array.length
    puts "invald input"
    puts ""
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
  puts ""
  puts "#{actor_array[argument]}! Love that guy."
  puts "Enter a number to learn more about: "
  puts "1 - his cars"
  puts "2 - his movies"
  puts "3 - his highest rated movie and the car in it"
  puts "4 - Go back to Actors menu"
  puts "5 - Go back to main menu"
  input = gets.chomp
  if input == 4.to_s
    actor_menu
  elsif input == 5.to_s
    menu
  elsif input == 1.to_s
    puts ""
    puts "#{actor_array[argument]} drove "
    actor_match(actor_array[argument]).cars.each do |car|
      puts car.name
    end
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    puts ""
    puts "#{actor_array[argument]} appeared in "
    actor_match(actor_array[argument]).movies.each do |movie|
      puts movie.title
    end
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    a = actor_match(actor_array[argument]).movies.max_by do |movie|
      movie.rotten_tomatoes_critic_score
    end
    puts ""
    puts "#{a.title} got #{a.rotten_tomatoes_critic_score}% on Rotten Tomatoes"
    puts "in which #{actor_array[argument]} drove a sweet #{a.car.name}"
    sleep 2
    puts ""
    menu
  else
    puts "invalid input"
    puts ""
    actor_menu_specifics(argument)
  end
end

def movie_menu
  puts ""
  puts "**Movies**"
  puts ""
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
    puts ""
    movie_menu
  else
    movie_menu_specifics(input.to_i - 1)
  end
end

def movie_menu_specifics(argument)
  puts ""
  puts "#{movie_array[argument]}! Love that film!"
  puts "Enter a number for its: "
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
    puts ""
    puts "#{movie_match(movie_array[argument]).actor.name} played James Bond in #{movie_array[argument]}"
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    puts ""
    puts "#{movie_array[argument]}'s"
    puts "Box Office Actual Gross: "
    g = movie_match(movie_array[argument]).box_office_actual.to_i * 1000000
    puts g
    puts "Box Office Gross Adjusted for Inflation: "
    h = movie_match(movie_array[argument]).box_office_adjusted.to_i * 1000000
    puts h
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    puts ""
    puts "#{movie_array[argument]}'s signature care was the #{movie_match(movie_array[argument]).car.name}"
    sleep 2
    puts ""
    menu
  elsif input == 4.to_s
    puts "#{movie_array[argument]}'s Rotten Tomatoes Critic score: #{movie_match(movie_array[argument]).rotten_tomatoes_critic_score}%"
    puts "#{movie_array[argument]}'s Rotten Tomatoes Audience score: #{movie_match(movie_array[argument]).rotten_tomatoes_audience_score}%"
    sleep 2
    puts ""
    menu
  else
    puts "invalid input"
    puts ""
    movie_menu_specifics(argument)
  end
end

def movie_match(film)
  #returns the movie object of a given movie title
  Movie.all.find do |movie_instance|
    movie_instance["title"] == film
  end
end

def car_menu
  puts ""
  puts "**Cars**"
  puts ""
  i = 1
  car_array.each do |car|
    puts "#{i} - #{car}"
    i += 1
  end
  puts "Enter a car for more info or b for back"
  input = gets.chomp
  if input == "b"
    puts ""
    menu
  elsif input.to_i <= 0 || input.to_i > car_array.length
    puts "invald input"
    puts ""
    car_menu
  else
    car_menu_specifics(input.to_i - 1)
  end
end

def car_menu_specifics(argument)
  puts ""
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
    puts "The #{car_array[argument]} appears in"
    car_match(car_array[argument]).movies.each do |movie|
      puts movie.title
    end
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    array = []
    car_match(car_array[argument]).actors.each do |actor|
      array << actor.name
    end
    array_2 = array.uniq
    puts "The #{car_array[argument]} was driven by"
    puts array_2
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    a = car_match(car_array[argument]).movies.max_by do |movie|
      movie.rotten_tomatoes_critic_score
    end
    puts ""
    puts "#{a.title} got #{a.rotten_tomatoes_critic_score}% on Rotten Tomatoes"
    puts "in which #{a.car.name} was driven"
    sleep 2
    puts ""
    menu
  else
    puts "invalid input"
    puts ""
    car_menu_specifics(argument)
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
