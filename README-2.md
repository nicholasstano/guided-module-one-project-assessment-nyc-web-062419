Description
===========
James-Bond-Car-Pedia is a searchable, updatable database focused on James Bond movies, the actors playing James Bond, and the signature cars featured in the James Bond movies.

Badges
======

Visuals
=======

Installation
============
Running Terminal from within project directory:

Type "bundle install" to install the required gems.

Type "rake db:migrate" to generate the necessary tables.

Type "rake console", then type the following three commands to populate the database:
create_current_bond_actors
create_current_bond_cars
create_current_bond_movies
(It is imperative to type the commands in this order)



Usage
=====
Running Terminal from within the project directory:

Type "ruby bin/run.rb" to open the program. A Welcome message and menu will appear.

Press the necessary keys to navigate the application.

To navigate the program
-----------------------
The program has three main components accessible from the main menu:
Actors
Movies
Cars

Within the Actors component, the user may select an actor to see which cars he drove, which movies he appeared in, and his highest-rated movie and the car he drove in it.

Within the Movies component, the user may select a movie to see which actor played James Bond in it, the movie's box office results (both actual and adjusted for inflation), the movie's signature car, and the movie's Rotten Tomatoes scores (both critic score and audience score).

Within the Cars component, the user may select a car to see which movies it appeared in, which actors drove it, and the highest-rated movie it appeard in.

To add a record to the database
-------------------------------
Inside the main menu ("Menu"), instead of entering one of the four listed options, enter "007". A prompt will appear asking if the user wishes to add records to the database. Press "y" to add records to the database.

The user will be prompted to enter a name for the actor, a name for the car, and a title, year, Rotten Tomatoes ratings, and box office numbers for the movie to be added. Upon successful completion, a note will appear indicating the movie has been added to the database and the program will return to the main menu.

Support
=======
This program is currently supported by Dave Bushnell, who is reachable at dybushnell@gmail.com. Nick Stano is unreachable at this time.

Roadmap
=======
Future releases may include including the model of the car (currently only the make is listed); and updating 


