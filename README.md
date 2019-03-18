# README

# Book Club


## Description

* This app can be used to manage a book club.
* Users can sign up to the book club to make an account. Logging in is required.
* Users can use Facebook to create their Book Club user profile, and/or log in.
* The book club has a set library of books.
* Each user can submit one review for each book.
* A user can also edit and/or delete reviews they have written.
* A user can not edit and/or delete reviews written by another user.
* Users can see all the reviews for a particular book, and also the average star rating for a book.
* Users can also sort the book list by book title, author, average star rating, and number of reviews.


## Installation

To use this app:

* Clone repo
* Run `rake db:migrate`
* If you have your own list of books, change the default db/seeds.rb file.
* Run `rake db:seed` (to create the library of books)
* Launch the app by starting a sever with `rails s` 


## Contributor's Guide

If you notice a problem or have a suggestion, please raise a Github issue containing a clear description, relevant snippets of the content, and/or screenshots if applicable.


## License
<p>The <a href='https://opensource.org/licenses/MIT' title='MIT License'>MIT License</a> applies. </p>
