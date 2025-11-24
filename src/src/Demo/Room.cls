Class Demo.Room Extends %Persistent
{

Property RoomId As %String [ Required ];

Property BedType As DataType.StringEnum.RoomBedType [ Required ];

Property HasBath As %Boolean [ InitialExpression = 1, Required ];

Index Pk On RoomId [ IdKey, PrimaryKey ];

Storage Default
{
<Data name="RoomDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>BedType</Value>
</Value>
<Value name="3">
<Value>HasBath</Value>
</Value>
</Data>
<DataLocation>^Demo.RoomD</DataLocation>
<DefaultData>RoomDefaultData</DefaultData>
<IdLocation>^Demo.RoomD</IdLocation>
<IndexLocation>^Demo.RoomI</IndexLocation>
<StreamLocation>^Demo.RoomS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
