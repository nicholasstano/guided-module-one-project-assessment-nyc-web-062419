DESCRIPTION
===========
James-Bond-Car-Pedia is a searchable, updatable database focused on James Bond movies, the actors playing James Bond, and the signature cars featured in the James Bond movies.


INSTALLATION
============
Running Terminal from within project directory:

Type 
```$ bundle install``` 
to install the required gems.

Type 
```$ rake db:migrate``` 
to generate the necessary tables.

Type 
```$ rake console```
then type the following three commands to populate the database:

```$ create_current_bond_actors```

```$ create_current_bond_cars```

```$ create_current_bond_movies```

It is important to type the commands in this order to initialize the program the first time. The second time the program is opened the database will be populated and these steps won't need to be repeated.


USAGE
=====
Running Terminal from within the project directory:

Type 
```$ ruby bin/run.rb``` 
to open the program. A Welcome message and menu will appear.

Press the necessary keys to navigate the application.

To navigate the program
-----------------------
The program has three main components accessible from the main menu:

```1 - list actors```

```2 - list movies```

```3 - list cars```

Within the Actors component, the user may select an actor to see which cars he drove, which movies he appeared in, and his highest-rated movie and the car he drove in it.

Within the Movies component, the user may select a movie to see which actor played James Bond in it; its worldwide box office gross; its signature car; and the its Rotten Tomatoes scores (both critic score and audience score).

Within the Cars component, the user may select a car to see which movies it appeared in, which actors drove it, and the highest-rated movie it appeard in.

To add a record to the database
-------------------------------
Inside the main menu ```Menu:```, instead of entering one of the four listed options, enter ```007``` . A prompt will appear asking if the user wishes to add or delete records to the database. Press ```y``` to add records to the database.

The user will be prompted to enter a name for the actor, a name for the car, and a title, year, Rotten Tomatoes ratings, and box office gross for the movie to be added. Upon successful completion, a note will appear indicating the movie has been added to the database and the program will return to the main menu.

To delete a record from the database
-------------------------------
Inside the main menu ```Menu:```, instead of entering one of the four listed options, enter ```007``` . A prompt will appear asking if the user wishes to add or delete records to the database. Press ```z``` to add records to the database.

The user will be prompted whether they wish to delete an actor, a movie, or a car. Only those records which have been manually entered by the user can be deleted. Upon successful deletion, a note will appear indicating which record has been deleted from the database and the program will return to the deletion menu. Please note that deleting a record will cause that record's associations to disappear (eg, deleting an actor but not his associated car(s) or movie(s) will cause those records to have no actor associated with them).


SUPPORT
=======
This program is currently supported by Dave Bushnell, who is reachable at dybushnell@gmail.com. Nick Stano is unreachable at this time (he's in space, "attempting re-entry.")


ROADMAP
=======
Future releases may include including the model of the car, as currently only the make is listed; adding pictures of the cars; updating the database upon the release of new James Bond movies; and adding non-EMI Bond movies (eg 1967's Casino Royale and 1983's Never Say Never Again).


CONTRIBUTING
============
There is no need for contributors at this time.


AUTHORS AND ACKNOWLEDGMENT
==========================
Nick Stano would like to thank Dave for his collaborations on the project as well as vision in finding the best possible CSV. Nick also thanks individuals at the Flatiron School, especially Brianna, Jeff and Tashawn.  Finally, Nick thanks Tim Freeman.
Dave Bushnell would like to thank Nick for his guidance, assistance, and fast typing. Dave would also like to thank the Flatiron School, Brianna, Jeff, and Tashawn. 


LICENSE
=======
MIT License

Copyright (c) 2019 Nick Stano and Dave Bushnell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
