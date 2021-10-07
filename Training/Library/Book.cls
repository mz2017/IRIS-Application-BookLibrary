/// Book class
Class Training.Library.Book Extends (%Persistent, %XML.Adaptor, %ZEN.DataModel.Adaptor)
{

/// Title
Property Title As %String [ Required ];

/// AUthor
Property Author As Training.Library.Person;

/// Genre
Property Genre As %String;

/// Friend
Property Friend As Training.Library.Person;

Storage Default
{
<Data name="BookDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Title</Value>
</Value>
<Value name="3">
<Value>Author</Value>
</Value>
<Value name="4">
<Value>Genre</Value>
</Value>
<Value name="5">
<Value>Friend</Value>
</Value>
</Data>
<DataLocation>^Training.Library.BookD</DataLocation>
<DefaultData>BookDefaultData</DefaultData>
<IdLocation>^Training.Library.BookD</IdLocation>
<IndexLocation>^Training.Library.BookI</IndexLocation>
<StreamLocation>^Training.Library.BookS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
