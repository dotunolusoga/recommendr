# recommendr
A book recommendation app - An interactive Ruby Command Line Application

# Project Vision

This will be a command line program that asks a user about the weather, their mood etc and uses this information to recommend a book that's intended to change their mood(not always for the better), as well as give witty puns, insults or sayings.

## Features

### Getting a recommendation

Users receive recommendations for books to read based on their answers to questions on their mood.

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

> y

```
Cool. Take a gander at "To The Hilt by Dick Francis". It's a fun, easy read about horses, what could be better?
```

Acceptance Criteria:
  * A book recommendation is given.
  * With the name of the author as well as a witty quip at the end.


### View all existing book recommendations

Evaluating all existing book recommendations

Usage example:
```
> ./recommendr manage
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
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
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```
> 1

What is the book title?

> To the Hilt

Who is the author?

> Dick Francis

What is the attached saying?

> "Man does not control his own fate. The women in his life do that for him."

Source of the saying?

> Groucho Marx 

```
"To The Hilt by Dick Francis" has been added to recommendations
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```
Acceptance Criteria:

* The program prints out confirmation that the new recommendation has been added
* The new recommendation is added to the database
* After the addition the user is taken back to the main manage menu


### Editing a recommendation

Updating existing books to keep recommendation relevant and entertaining, or to change the saying attached to it, and also to fix typos.

I want to edit an existing recommendation

Usage example:
```
> ./recommender manage

1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```
> 2

```
Which recommendation fails to meet your exacting standards "Oh Great & Powerful One"?

1. Game Of Thrones - George R. R. Martin | You seem too chipper. This book where(spoiler alert) everyone dies, should cut you down to size!
2. Prodigal Daughter - Jeffrey Archer | "Some people claim that marriage interferes with romance. There's no doubt about it. Anytime you have a romance, your wife is bound to interfere." — Groucho Marx
3. The Third Twin - Ken Follett | "Only one man in a thousand is a leader of men -- the other 999 follow women." — Groucho Marx
```
> 3


You want to edit "The Third Twin - Ken Follett"? (y/n)

> y

Edit book title?(y/n)

> y

New book title?

> Mexico

Edit book author?(y/n)

> y

New author?

> James Michener

Edit saying?(y/n)

> n

```
"The Third Twin by Ken Follett" has been edited
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```


Acceptance Criteria:

* The program prints out confirmation that the recommendation has been deleted
* The edited recommendation is updated in the database
* All references to the edited recommendation are updated in the database
* After the editing the user is taken back to the main manage menu



### Deleting a recommendation

In order to remove duplicates and/or recommendations that do not excite/depress a user

I want to delete an existing recommendation

Usage example:
```
> ./recommender manage

1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```
> 3

```
Which recommendation fails to meet your exacting standards "Oh Great & Powerful One"?

1. Game Of Thrones - George R. R. Martin | You seem too chipper. This book where(spoiler alert) everyone dies, should cut you down to size!
2. Prodigal Daughter - Jeffrey Archer | "Some people claim that marriage interferes with romance. There's no doubt about it. Anytime you have a romance, your wife is bound to interfere." — Groucho Marx
3. The Third Twin - Ken Follett | "Only one man in a thousand is a leader of men -- the other 999 follow women." — Groucho Marx
```
> 3


```
Are you sure? (y/n)
```
> y


```
"The Third Twin by Ken Follett" has been deleted
1. Add a recommendation
2. Edit a recommendation
3. Delete a recommendation
4. List all recommendations
5. Exit
```


Acceptance Criteria:

* The program prints out confirmation that the recommendation has been deleted
* The deleted recommendation is removed from the database
* All references to the deleted recommendation are removed from the database
* After the deletion the user is taken back to the main manage menu
