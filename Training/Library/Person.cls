/// Person class
Class Training.Library.Person Extends (%Persistent, %XML.Adaptor, %ZEN.DataModel.Adaptor)
{

/// Name
Property Name As %String [ Required ];

/// Phone number
Property PhoneNumber As %String;

Index NameIndex On Name [ Unique ];

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>PhoneNumber</Value>
</Value>
</Data>
<DataLocation>^Training.Library.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^Training.Library.PersonD</IdLocation>
<IndexLocation>^Training.Library.PersonI</IndexLocation>
<StreamLocation>^Training.Library.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
