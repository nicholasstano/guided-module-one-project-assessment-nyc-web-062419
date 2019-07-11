require "rest-client"
require "json"
require "pry"

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

def create_current_bond_actors
  actor_array.each do |actor|
    if Actor.all.length >= 6
      nil
    else
      Actor.create(name: actor, original_db: true)
    end
  end
end

def car_array
  bond_array.map do |movie_instance|
    movie_instance["car"]
  end.uniq
end

def create_current_bond_cars
  car_array.each do |car|
    if Car.all.length == 12
      nil
    else
      Car.create(name: car, original_db: true)
    end
  end
end

def movie_array
  bond_array.map do |movie_instance|
    movie_instance["title"]
  end.uniq
end

def create_current_bond_movies
  if Movie.all.length == 23
    nil
  else
    bond_array.each do |movie_instance|
      a = Actor.find_by(name: movie_instance["actor"])
      c = Car.find_by(name: movie_instance["car"])
      Movie.create(title: movie_instance["title"], year: movie_instance["year"], rotten_tomatoes_critic_score: movie_instance["rotten_tomatoes_critic_score"], rotten_tomatoes_audience_score: movie_instance["rotten_tomatoes_audience_score"], box_office_actual: movie_instance["box_office_actual"], box_office_adjusted: movie_instance["box_office_adjusted"], actor_id: a.id, car_id: c.id, original_db: true)
    end
  end
end

def inflation_hash
  response_string = RestClient.get("http://dybushnell.com/bond/inflation.txt")
  response_hash = JSON.parse(response_string)
  response_hash
end
