require_relative "../app/models/actor.rb"
require_relative "../app/models/movie.rb"
require_relative "../app/models/car.rb"

def welcome
  #sleep 1
  logo = Artii::Base.new :font => "slant"
  puts logo.asciify("007")
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
    puts "press y to create a new James Bond actor, car & movie."
    puts "press z to delete an entry"
    puts "press any other key to return to the main menu"
    input_2 = gets.chomp
    if input_2 == "y"
      creation_menu
    elsif input_2 == "z"
      deletion_menu
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
    actor.name.downcase == input_actor.downcase
  end
  this_actor = actor_object
  if this_actor == nil
    this_actor = Actor.create(name: input_actor, original_db: false)
  end

  puts "Enter a car"
  input_car = gets.chomp.rstrip
  this_car = nil
  car_object = Car.all.find do |car|
    car.name.downcase == input_car.downcase
  end
  this_car = car_object
  if this_car == nil
    this_car = Car.create(name: input_car, original_db: false)
  end

  # binding.pry

  puts "Enter a movie title"
  input_title = gets.chomp
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

    this_title = Movie.create(title: input_title, year: input_year, rotten_tomatoes_critic_score: input_rtcs, rotten_tomatoes_audience_score: input_rtas, box_office_actual: input_actual, box_office_adjusted: nil, actor_id: this_actor.id, car_id: this_car.id, original_db: false)
    puts "Movie added to database!"
    menu
  else
    puts "This title already exists"
  end
end

def deletion_menu
  puts ""
  puts "Delete:"
  puts "1 - an actor"
  puts "2 - a car"
  puts "3 - a movie"
  puts "4 - Back to Main Menu"
  input = gets.chomp
  if input == "1"
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
      if input_2.to_i > new_actor_array.length
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
  elsif input == "2"
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
      if input_2.to_i > new_car_array.length
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
  elsif input == "3"
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
      if input_2.to_i > new_movie_array.length
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
end

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
    puts ""
    puts "#{Actor.all[argument].name} drove "
    Actor.all[argument].movies.each do |movie|
      puts "#{movie.car.name} in #{movie.title}"
    end
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    puts ""
    puts "#{Actor.all[argument].name} appeared in "
    Actor.all[argument].movies.each do |movie|
      puts movie.title
    end
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    a = Actor.all[argument].movies.max_by do |movie|
      movie.rotten_tomatoes_critic_score
    end
    puts ""
    puts "#{a.title} got #{a.rotten_tomatoes_critic_score}% on Rotten Tomatoes"
    puts "in which #{Actor.all[argument].name} drove a sweet #{a.car.name}"
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
end

def separate_comma(number)
  comma_number = number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
end

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
    puts ""
    puts "#{Movie.all[argument].actor.name} played James Bond in #{Movie.all[argument].title}"
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    puts ""
    puts "#{Movie.all[argument].title}'s"
    puts "Worldwide Box Office Gross (#{Movie.all[argument].year}): "
    g = Movie.all[argument].box_office_actual.to_i * 1000000
    puts "$#{separate_comma(g)} USD"
    puts "Worldwide Box Office Gross (adjusted for 2019): "
    h = g * 8.48 / inflation_hash[0][Movie.all[argument].year.to_s]
    puts "$#{separate_comma(h.to_i)} USD"
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    puts ""
    puts "In #{Movie.all[argument].title} James Bond's signature car was the #{Movie.all[argument].car.name}"
    sleep 2
    puts ""
    menu
  elsif input == 4.to_s
    puts "#{Movie.all[argument].title}'s Rotten Tomatoes Critic score: #{Movie.all[argument].rotten_tomatoes_critic_score}%"
    puts "#{Movie.all[argument].title}'s Rotten Tomatoes Audience score: #{Movie.all[argument].rotten_tomatoes_audience_score}%"
    sleep 2
    puts ""
    menu
  else
    puts "invalid input"
    puts ""
    movie_menu_specifics(argument)
  end
end

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
end

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
    puts "The #{Car.all[argument].name} appears in"
    Car.all[argument].movies.each do |movie|
      puts movie.title
    end
    sleep 2
    puts ""
    menu
  elsif input == 2.to_s
    array = []
    Car.all[argument].actors.each do |actor|
      array << actor.name
    end
    array_2 = array.uniq
    puts ""
    puts "The #{Car.all[argument].name} was driven by"
    puts array_2
    sleep 2
    puts ""
    menu
  elsif input == 3.to_s
    a = Car.all[argument].movies.max_by do |movie|
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
