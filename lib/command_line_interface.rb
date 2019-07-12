require_relative "../app/models/actor.rb"
require_relative "../app/models/movie.rb"
require_relative "../app/models/car.rb"

def welcome
  logo = Artii::Base.new :font => "slant"
  puts logo.asciify("007")
  sleep 1
  puts "Welcome to James-Bond-Car-Pedia!"
  puts ""
  puts "The database that includes #{Movie.all.length} films, #{Actor.all.length} actors who have played James Bond, and #{Car.all.length} cars."
  puts ""
end #end welcome

def menu
  puts ""
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
    puts "The name's Bond, James Bond."
  elsif input == "007"
    puts ""
    puts "press y to create a new James Bond actor, car & movie."
    puts "press z to delete an entry"
    puts "press any other key to return to the main menu"
    input_2 = gets.chomp
    if input_2 == "y"
      puts ""
      creation_menu
    elsif input_2 == "z"
      puts ""
      deletion_menu
    else
      menu
    end
  else
    puts "invalid input"
    puts ""
    menu
  end
end #end menu

def creation_menu
  puts "Enter an actor"
  input_actor = gets.chomp.rstrip
  this_actor = c_create_actor(input_actor)
  puts "Enter a car"
  input_car = gets.chomp.rstrip
  this_car = c_create_car(input_car)
  puts "Enter a movie title"
  input_title = gets.chomp
  c_create_movie(input_title, this_actor, this_car)
end #end creation_menu

def deletion_menu
  puts ""
  puts "Delete:"
  puts "1 - an actor"
  puts "2 - a car"
  puts "3 - a movie"
  puts "4 - Back to Main Menu"
  input = gets.chomp
  if input == "1"
    d_delete_actor
  elsif input == "2"
    d_delete_car
  elsif input == "3"
    d_delete_movie
  elsif input == "4"
    menu
  else
    puts ""
    puts "invalid input!"
    deletion_menu
  end
end #end deletion_menu

def actor_menu
  puts ""
  puts "**Actors**"
  puts ""
  i = 1
  Actor.all.each do |actor|
    puts "#{i} - #{actor.name}"
    i += 1
  end
  puts ""
  puts "Enter an actor for more info or b for back"
  input = gets.chomp

  if input == "b"
    menu
  elsif input.to_i <= 0 || input.to_i > Actor.all.length
    puts "invald input"
    puts ""
    actor_menu
  else
    actor_menu_specifics(input.to_i - 1)
  end
end #end actor_menu

def actor_menu_specifics(argument)
  puts ""
  puts "#{Actor.all[argument].name}! Love that guy."
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
    a_actor_cars(argument)
  elsif input == 2.to_s
    a_actor_movies(argument)
  elsif input == 3.to_s
    a_highest_rated_movie_and_car(argument)
  else
    puts "invalid input"
    puts ""
    actor_menu_specifics(argument)
  end
end #end actor_menu_specifics

def movie_menu
  puts ""
  puts "**Movies**"
  puts ""
  i = 1
  Movie.all.each do |movie|
    puts "#{i} - #{movie.title}"
    i += 1
  end
  puts "Enter a movie for more info or b for back"
  input = gets.chomp
  if input == "b"
    menu
  elsif input.to_i <= 0 || input.to_i > Movie.all.length
    puts "invald input"
    puts ""
    movie_menu
  else
    movie_menu_specifics(input.to_i - 1)
  end
end #end movie_menu

def movie_menu_specifics(argument)
  puts ""
  puts "#{Movie.all[argument].title}! Love that film!"
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
    m_show_actor(argument)
  elsif input == 2.to_s
    m_show_box_office_gross(argument)
  elsif input == 3.to_s
    m_show_car_featured(argument)
  elsif input == 4.to_s
    m_show_rt_score(argument)
  else
    puts "invalid input"
    puts ""
    movie_menu_specifics(argument)
  end
end #end movie_menu_specifics

def car_menu
  puts ""
  puts "**Cars**"
  puts ""
  i = 1
  Car.all.each do |car|
    puts "#{i} - #{car.name}"
    i += 1
  end
  puts "Enter a car for more info or b for back"
  input = gets.chomp
  if input == "b"
    puts ""
    menu
  elsif input.to_i <= 0 || input.to_i > Car.all.length
    puts "invald input"
    puts ""
    car_menu
  else
    car_menu_specifics(input.to_i - 1)
  end
end #end car_menu

def car_menu_specifics(argument)
  puts ""
  puts "#{Car.all[argument].name}! Love that car!!"
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
    c_movies(argument)
  elsif input == 2.to_s
    c_actors(argument)
  elsif input == 3.to_s
    c_highest_rated_movie(argument)
  else
    puts "invalid input"
    puts ""
    car_menu_specifics(argument)
  end
end #car_menu_specifics
