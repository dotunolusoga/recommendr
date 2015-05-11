# recommendr
A book recommendation app - An interactive Ruby Command Line Application

# Project Vision

This will be a command line program that asks a user about the weather, their mood etc and uses this information to recommend a book that's intended to change their mood(not always for the better), as well as give witty puns, insults or sayings.

## Features

### Getting a recommendation

Users receive recommendations for books to read based on their answers to questions on their mood, and the current weather

### Adding a new book

In order to provide a wide range of options to users, new books can be added

### Editing existing books

Updating existing books to keep recommendation relevant and entertaining, and also to fix typos.


### Get a recommendation

Getting a book recommendation

Usage example:
```
> ./recommendr
How do you feel today?
1. Happy
2. Miserable
3. So So
```
> 2

Can we recommend a book for you?(y/n)

> 1

```
Cool. Take a gander at "To The Hilt by Dick Francis". It's a fun, easy read about horses, what could be better?
1. Add a recommendation
2. List all recommendations
3. Exit
```

Acceptance Criteria:
    * A book recommendation is given.
    * With the name of the author as well as a witty quip at the end.
    * After the recommendation, the user is taken back to the main manage menu


### View all existing book recommendations

Evaluating all existing book recommendations

Usage example:
```
> ./recommendr manage
1. Add a recommendation
2. List all recommendations
3. Exit
```
> 2

1. Game Of Thrones - George R. R. Martin
2. Prodigal Daughter - Jeffrey Archer
3. The Third Twin - Ken Follett

Acceptance Criteria:

  * All recommendations are printed out
  * Each recommendation is given a number, which does not correspond to its database id


### Adding a recommendation

Usage example:
```
> ./recommendr manage
1. Add a recommendation
2. List all recommendations
3. Exit
```
> 1

What is the book title?

> To the Hilt

Who is the author?

> Dick Francis

```
"To The Hilt by Dick Francis" has been added to recommendations
1. Add a recommendation
2. List all recommendations
3. Exit
```
Acceptance Criteria:

* The program prints out confirmation that the new recommendation has been added
* The new recommendation is added to the database
* After the addition the user is taken back to the main manage menu



### Deleting a recommendation

In order to remove duplicates and/or recommendations that do not excite/depress a user
I want to delete an existing recommendation

Usage example:
```
> ./recommender manage

1. Add a recommendation
2. List all recommendations
3. Exit
```
> 2

```
1. Game Of Thrones - George R. R. Martin
2. Prodigal Daughter - Jeffrey Archer
3. The Third Twin - Ken Follett
```
> 3


```
Would you like to?
1. Edit
2. Delete
3. Exit
```
> 2


```
"The Third Twin by Ken Follett" has been deleted
1. Add a recommendation
2. List all recommendations
3. Exit
```


Acceptance Criteria:

* The program prints out confirmation that the recommendation has been deleted
* The deleted recommendation is removed from the database
* All references to the deleted recommendation are removed from the database
* After the deletion the user is taken back to the main manage menu
