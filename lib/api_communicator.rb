require "rest-client"
require "json"
require "pry"

def bond_array
  response_string = RestClient.get("http://dybushnell.com/bond/bonddata_edit.txt")
  response_hash = JSON.parse(response_string)
  response_hash
end #end bond_array

def actor_array
  bond_array.map do |movie_instance|
    movie_instance["actor"]
  end.uniq
end #end actor_array

def create_current_bond_actors
  actor_array.each do |actor|
    if Actor.all.length >= 6
      nil
    else
      Actor.create(name: actor, original_db: true)
    end
  end
end #end create_current_bond_actors

def car_array
  bond_array.map do |movie_instance|
    movie_instance["car"]
  end.uniq
end #end car_array

def create_current_bond_cars
  car_array.each do |car|
    if Car.all.length == 12
      nil
    else
      Car.create(name: car, original_db: true)
    end
  end
end #end create_current_bond_cars

def movie_array
  bond_array.map do |movie_instance|
    movie_instance["title"]
  end.uniq
end #end movie_array

def create_current_bond_movies
  if Movie.all.length == 24
    nil
  else
    bond_array.each do |movie_instance|
      a = Actor.find_by(name: movie_instance["actor"])
      c = Car.find_by(name: movie_instance["car"])
      Movie.create(title: movie_instance["title"], year: movie_instance["year"], rotten_tomatoes_critic_score: movie_instance["rotten_tomatoes_critic_score"], rotten_tomatoes_audience_score: movie_instance["rotten_tomatoes_audience_score"], box_office_actual: movie_instance["box_office_actual"], actor_id: a.id, car_id: c.id, original_db: true)
    end
  end
end #end create_current_bond_movies

def inflation_hash
  response_string = RestClient.get("http://dybushnell.com/bond/inflation.txt")
  response_hash = JSON.parse(response_string)
  response_hash
end #end inflation_hash

def m_show_actor(argument)
  puts ""
  if Movie.all[argument].actor == nil
    puts "Actor missing (deleted by user)"
  else
    puts "#{Movie.all[argument].actor.name} played James Bond in #{Movie.all[argument].title}"
  end
  sleep 1
  puts ""
  movie_menu_specifics(argument)
end #end m_show_actor

def separate_comma(number)
  comma_number = number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
end #end separate_comma

def m_show_box_office_gross(argument)
  puts ""
  puts "#{Movie.all[argument].title}'s"
  puts "Worldwide Box Office Gross (#{Movie.all[argument].year}): "
  g = Movie.all[argument].box_office_actual.to_i * 1000000
  puts "$#{separate_comma(g)} USD"
  puts "Worldwide Box Office Gross (adjusted for 2019): "
  if Movie.all[argument].year < 1962 || Movie.all[argument].year.to_s == nil
    puts "data unavailable (invalid year)"
  else
    h = g * 8.48 / inflation_hash[0][Movie.all[argument].year.to_s]
    puts "$#{separate_comma(h.to_i)} USD"
  end
  sleep 1
  puts ""
  movie_menu_specifics(argument)
end #m_show_box_office_gross

def m_show_car_featured(argument)
  puts ""
  if Movie.all[argument].car == nil
    puts "Car missing (deleted by user)"
  else
    puts "In #{Movie.all[argument].title} James Bond's signature car was the #{Movie.all[argument].car.name}"
  end
  sleep 1
  puts ""
  movie_menu_specifics(argument)
end #m_show_car_featured

def m_show_rt_score(argument)
  puts ""
  puts "#{Movie.all[argument].title}'s Rotten Tomatoes Critic score: #{Movie.all[argument].rotten_tomatoes_critic_score}%"
  puts "#{Movie.all[argument].title}'s Rotten Tomatoes Audience score: #{Movie.all[argument].rotten_tomatoes_audience_score}%"
  sleep 1
  puts ""
  movie_menu_specifics(argument)
end #end m_show_rt_score

def a_actor_cars(argument)
  puts ""
  if Actor.all[argument].cars == []
    puts "No cars available for this actor (deleted by user)"
  else
    puts "#{Actor.all[argument].name} drove "
    Actor.all[argument].movies.each do |movie|
      puts "#{movie.car.name} in #{movie.title}"
    end
  end
  sleep 1
  puts ""
  actor_menu_specifics(argument)
end #end a_actor_cars

def a_actor_movies(argument)
  puts ""
  if Actor.all[argument].movies == []
    puts "No movies available for this actor (deleted by user)"
  else
    puts "#{Actor.all[argument].name} appeared in "
    Actor.all[argument].movies.each do |movie|
      puts movie.title
    end
  end
  sleep 1
  puts ""
  actor_menu_specifics(argument)
end #end a_actor_movies

def a_highest_rated_movie_and_car(argument)
  if Actor.all[argument].movies == []
    puts ""
    puts "No movies available for this actor (deleted by user)"
  else
    a = Actor.all[argument].movies.max_by do |movie|
      movie.rotten_tomatoes_critic_score
    end
    puts ""
    puts "#{a.title} got #{a.rotten_tomatoes_critic_score}% on Rotten Tomatoes"
    puts "in which #{Actor.all[argument].name} drove a sweet #{a.car.name}"
  end
  sleep 1
  puts ""
  actor_menu_specifics(argument)
end #end a_highest_rated_movie_and_car

def c_movies(argument)
  if Car.all[argument].movies == []
    puts ""
    puts "No movies available for #{Car.all[argument].name} (deleted by user)"
  else
    puts ""
    puts "The #{Car.all[argument].name} appears in"
    Car.all[argument].movies.each do |movie|
      puts movie.title
    end
  end
  sleep 1
  puts ""
  car_menu_specifics(argument)
end #end c_movies

def c_actors(argument)
  if Car.all[argument].actors == []
    puts ""
    puts "No actors available for #{Car.all[argument].name} (deleted by user)"
  else
    array = []
    Car.all[argument].actors.each do |actor|
      array << actor.name
    end
    array_2 = array.uniq
    puts ""
    puts "The #{Car.all[argument].name} was driven by"
    puts array_2
  end
  sleep 1
  puts ""
  car_menu_specifics(argument)
end #end c_actors

def c_highest_rated_movie(argument)
  if Car.all[argument].movies == []
    puts ""
    puts "No movies available for #{Car.all[argument].name} (deleted by user)"
  else
    a = Car.all[argument].movies.max_by do |movie|
      movie.rotten_tomatoes_critic_score
    end
    puts ""
    puts "#{a.title} got #{a.rotten_tomatoes_critic_score}% on Rotten Tomatoes"
    puts "in which #{a.car.name} was driven"
  end
  sleep 1
  puts ""
  car_menu_specifics(argument)
end #end c_highest_rated_movie

def d_delete_movie
  puts ""
  new_movie_array = []
  new_movie_array = Movie.all.select do |movie_instance|
    movie_instance.original_db == false
  end
  if new_movie_array.length == 0
    puts "No movies can be deleted"
    deletion_menu
  else
    puts "Select a movie to delete:"

    i = 0
    while i < new_movie_array.length
      puts "#{i + 1} - #{new_movie_array[i].title}"
      i += 1
    end
    puts "or press any other key to go back"
    input_2 = gets.chomp
    if input_2.to_i <= 0 || input_2.to_i > new_movie_array.length
      puts ""
      puts "invalid input!"
      deletion_menu
    else
      movie = new_movie_array[input_2.to_i - 1].title
      Movie.all.delete(new_movie_array[(input_2.to_i) - 1])
      puts ""
      puts "#{movie} deleted!"
      deletion_menu
    end
  end
end #end d_delete_movie

def d_delete_car
  puts ""
  new_car_array = []
  new_car_array = Car.all.select do |car_instance|
    car_instance.original_db == false
  end
  if new_car_array.length == 0
    puts "No cars can be deleted"
    deletion_menu
  else
    puts "Select a car to delete:"

    i = 0
    while i < new_car_array.length
      puts "#{i + 1} - #{new_car_array[i].name}"
      i += 1
    end
    puts "or press any other key to go back"

    input_2 = gets.chomp
    if input_2.to_i <= 0 || input_2.to_i > new_car_array.length
      puts ""
      puts "invalid input!"
      deletion_menu
    else
      # binding.pry

      car = new_car_array[input_2.to_i - 1].name
      Car.all.delete(new_car_array[(input_2.to_i) - 1])
      puts ""
      puts "#{car} deleted!"
      deletion_menu
    end
  end
end #end d_delete_car

def d_delete_actor
  puts ""
  new_actor_array = []
  new_actor_array = Actor.all.select do |actor_instance|
    actor_instance.original_db == false
  end
  if new_actor_array.length == 0
    puts "No actors can be deleted"
    deletion_menu
  else
    puts "Select an actor to delete:"

    i = 0
    while i < new_actor_array.length
      puts "#{i + 1} - #{new_actor_array[i].name}"
      i += 1
    end
    puts "or press any other key to go back"

    input_2 = gets.chomp
    if input_2.to_i <= 0 || input_2.to_i > new_actor_array.length
      puts ""
      puts "invalid input!"
      deletion_menu
    else
      actor = new_actor_array[input_2.to_i - 1].name
      Actor.all.delete(new_actor_array[(input_2.to_i) - 1])
      puts ""
      puts "#{actor} deleted!"
      deletion_menu
    end
  end
end #end d_delete_actor

def c_create_actor(input_actor)
  this_actor = nil
  actor_object = Actor.all.find do |actor|
    actor.name.downcase == input_actor.downcase
  end
  this_actor = actor_object
  if this_actor == nil
    this_actor = Actor.create(name: input_actor, original_db: false)
  end
end #end c_create_actor

def c_create_car(input_car)
  this_car = nil
  car_object = Car.all.find do |car|
    car.name.downcase == input_car.downcase
  end
  this_car = car_object
  if this_car == nil
    this_car = Car.create(name: input_car, original_db: false)
  end
end #end c_create_car

def c_create_movie(input_title, this_actor, this_car)
  this_title = nil
  title_object = Movie.all.find do |movie|
    movie.title.downcase == input_title.downcase
  end
  this_title = title_object
  if this_title == nil
    puts "Enter the year of the movie"
    input_year = gets.chomp.to_i
    puts "Enter the Rotten Tomatoes Critic Score"
    input_rtcs = gets.chomp.to_i
    puts "Enter the Rotten Tomatoes Audience Score"
    input_rtas = gets.chomp.to_i
    puts "Enter the Box Office Gross in millions (ex: 840 for 840,000,000)"
    input_actual = gets.chomp.to_i
    this_title = Movie.create(title: input_title, year: input_year, rotten_tomatoes_critic_score: input_rtcs, rotten_tomatoes_audience_score: input_rtas, box_office_actual: input_actual, actor_id: this_actor.id, car_id: this_car.id, original_db: false)
    puts "Movie added to database!"
    menu
  else
    puts "This title already exists"
    menu
  end
end #end c_create_movie
