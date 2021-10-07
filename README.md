# IRIS Application for Personal Book Libray

This is a simple IRIS server side application used to track books and people who loan books.

To run this application, make sure your project is attahed to a IRIS server (or simply load the XML to the server). Then you can use the IRIS terminal to test it, such as using the following steps.

### Test steps
1. Open a IRIS terminal
2. Change to the namespace where the classes were loaded
3. Start by creating some books in the database using command: 
    ```
    do ##class(Training.Library.LibraryUtils).AddBook()
    ```
4. Add a few friends to the database who will borrow the books: ```
    do ##class(Training.Library.LibraryUtils).AddFriend()
   ```
5. Check all the books created: ```
    do ##class(Training.Library.LibraryUtils).PrintAllBookInfo()
    ```
6. Loan a book to a friend: ```
    do ##class(Training.Library.LibraryUtils).LoanBook(bookId, friendName)
    ```
7. Print out all loaned books: ```
    do ##class(Training.Library.LibraryUtils).GetLoanedBooks()
    ```
8. Find all books loaned by one friend: ```
    do ##class(Training.Library.LibraryUtils).FriendOwe("David")
    ```
9. Make a book return: ```
    do ##class(Training.Library.LibraryUtils).ReturnBook(1)
    ```
10. Find out which friend loaned a specific book: ```
     do ##class(Training.Library.LibraryUtils).GetFriend(2)
    ```



