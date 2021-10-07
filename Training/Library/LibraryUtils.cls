/// Util class
Class Training.Library.LibraryUtils Extends %RegisteredObject
{

/// Create a new book
ClassMethod AddBook() As %Status
{
    // Create an object in which to store the book
	set book = ##class(Training.Library.Book).%New()
    read !,"Enter book title: ",title
    set book.Title = title

    read !,"Enter book author: ",author
    &sql(SELECT id INTO :id FROM training_library.person WHERE Name = :author)
    if ( id '= "") {
        set book.Author = ##class(Training.Library.Person).%OpenId(id)
    }
    else {
        set newPerson = ##class(Training.Library.Person).%New()
        set newPerson.Name = author
        set book.Author = newPerson
        set status = newPerson.%Save()
    }

    read !,"Enter book genra (1/2): ",genre
    if ( genre = "1" ) {
        set book.Genre = "Non ficton"
    }
    else {
        set book.Genre = "Ficton"
    }

    set status = book.%Save()
    return status
}

/// Add a new friend
ClassMethod AddFriend() As %Status
{
    set friend = ##class(Training.Library.Person).%New()
    read !,"Enter fiend name: ",name
    set friend.Name = name
    read !,"Enter fiend phone number: ",phone
    set friend.PhoneNumber = phone
    set status = friend.%Save()

    return status
}

/// Print info of a given book
ClassMethod PrintBookInfo(id As %String) As %Status
{
    Set book = ##class(Training.Library.Book).%OpenId(id)
    write !,?5,book.Title,?15,book.Author.Name,?25,book.Genre
    if ( book.Friend = "" ) {
        write !,"This book is currently in library."
    }
    else {
        write !,"This book is currently on loan to ",book.Friend.Name,". "
    }

    return $$$OK
}

/// Print all books in library
ClassMethod PrintAllBookInfo() As %Status
{
     &sql(declare CC cursor for SELECT id INTO :id FROM training_library.book)
     &sql(open CC)
     &sql(fetch CC)

    while ( SQLCODE=0) {
        set status = ##class(Training.Library.LibraryUtils).PrintBookInfo(id)
        &sql(fetch CC)
    }
    &sql(close CC)
    return $$$OK
}

/// Load a book to a friend
ClassMethod LoanBook(bookId As %String, friendName As %String) As %Status
{
    set book = ##class(Training.Library.Book).%OpenId(bookId)
    if ( book.Friend '= "" ) {
        write !,"Book with ID ",id," is on load to friend ",book.Friend.Name,". Please ask the loaner to return it first."
        quit $$$OK
    }
    else {
        &sql(SELECT id INTO :id FROM training_library.person WHERE Name = :friendName)
        if ( id '= "") {
            write !,"Friend ",friendName," not registered. Adding new record for the person now."
            set friend = ##class(Training.Library.Person).%OpenId(id)
            set book.Friend = friend
        }
        else {
            set newPerson = ##class(Training.Library.Person).%New()
            set newPerson.Name = friendName
            set book.Friend = newPerson
            set status = newPerson.%Save() 
        }
        write !,"Book with id ",bookId," is now loaned to ",friendName,"."
        set status = book.%Save()
        return status   
    }
}

/// Return a book
ClassMethod ReturnBook(bookId As %String) As %Status
{
    set book = ##class(Training.Library.Book).%OpenId(bookId)
    if ( book.Friend = "" ) {
        write !,"Book with id ",bookId," is not on loan. You must made a mistake."
        quit $$$OK
    }
    else {
        set friendName = book.Friend.Name
        set book.Friend = ""
        set status = book.%Save()
        write !,"Book with id ",bookId," is now returned by ",friendName,"."
        return status
    }
}

/// write out all books on loan
ClassMethod GetLoanedBooks() As %Status
{
     &sql(declare CC cursor for 
       SELECT id, title, friend->Name INTO :id, :title, :friend 
       FROM training_library.book
       WHERE friend IS NOT NULL)

     &sql(open CC)
     &sql(fetch CC)

    set count = 0
    while ( SQLCODE=0) {
        write !,"Book ",title," was loaned to ",friend
        set count = count +1
        &sql(fetch CC)
    }
    write !,"Total of ",count," book on loan."
    &sql(close CC)
    return $$$OK
}

/// Write out all book on shelf
ClassMethod GetShelfBooks() As %Status
{
    &sql(declare CC cursor for 
       SELECT id, title INTO :id, :title
       FROM training_library.book
       WHERE friend IS NULL)

    &sql(open CC)
    &sql(fetch CC)

    set count = 0
    while ( SQLCODE=0) {
        write !,"Book ",title," is on shelf."
        set count = count +1
        &sql(fetch CC)
    }
    write !,"Total of ",count," book on shelf."
    &sql(close CC)
    return $$$OK
}

/// SHow how many books a friend owe
ClassMethod FriendOwe(friendName As %String) As %Status
{
    &sql(SELECT id INTO :id FROM training_library.person WHERE Name = :friendName)
    if ( id = "") {
        write !,"Friend with name ",friendName," not in the system."
        quit $$$OK
    }
    else {
        &sql(SELECT count(id) into :count FROM training_library.book WHERE friend = :id)
        write !,"Friend ",friendName," has borrowed ",count," books."
        return $$$OK
    }
}

/// SHow which friend has a specific book
ClassMethod GetFriend(bookId) As %Status
{
    Set book = ##class(Training.Library.Book).%OpenId(bookId)
    if ( book.Friend '= "" ) {
        write !,"Book ",book.Title," is on loan to ",book.Friend.Name,"."
    }
    else {
        write !,"Book ",book.Title," is not on loan."
    }
    return $$$OK
}

}
