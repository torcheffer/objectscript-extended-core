/// Room's bed type
Class DataType.StringEnum.RoomBedType Extends DataType.Base.StringEnum
{

ClassMethod GetFqcn() As %String [ CodeMode = expression ]
{
"DataType.StringEnum.RoomBedType"
}

/// Single
ClassMethod Single() As RoomBedType [ CodeMode = objectgenerator ]
{
    Return:(%member '= "") $$$OK
    Do %code.WriteLine("   Return ""1S""")
}

/// Double
ClassMethod Double() As RoomBedType [ CodeMode = objectgenerator ]
{
    Return:(%member '= "") $$$OK
    Do %code.WriteLine("   Return ""2D""")
}

/// Twin
ClassMethod Twin() As RoomBedType [ CodeMode = objectgenerator ]
{
    Return:(%member '= "") $$$OK
    Do %code.WriteLine("   Return ""2T""")
}

/// Triple
ClassMethod Triple() As RoomBedType [ CodeMode = objectgenerator ]
{
    Return:(%member '= "") $$$OK
    Do %code.WriteLine("   Return ""3T""")
}

/// Quadruple
ClassMethod Quad() As RoomBedType [ CodeMode = objectgenerator ]
{
    Return:(%member '= "") $$$OK
    Do %code.WriteLine("   Return ""4Q""")
}

}
