/// Enum core implemention
Class DataType.Base.Enum Extends FqcnGettable [ Abstract ]
{

/// Get a %List of enumerator values.
ClassMethod GetValues() As %List [ CodeMode = objectgenerator, Final ]
{
    // If %member is not empty string, this method is evaluated as literal property method in an object class.
    // This method's implemention is meaningless in the case.
    Return:(%member '= "") $$$OK

    Set nqcn = $Piece(%class.Name, ".", *)
    #Dim methods As %Library.RelationshipObject = %class.Methods
    Set methodKey = ""
    #Dim methodNames As %List = ""
    While 1
    {
        #Dim method As %Dictionary.CompiledMethod = methods.GetNext(.methodKey)
        Quit:(methodKey = "")
        Continue:'(method.ClassMethod && (method.ReturnType = nqcn) && (method.FormalSpec = ""))
        Set $List(methodNames, $ListLength(methodNames) + 1) = method.Name
    }
    Do %code.Write("  Return $ListBuild(")
    For i = 1 : 1 : $ListLength(methodNames)
    {
        Do %code.Write(".."_$ListGet(methodNames, i)_"()")
        Do:(i '= $ListLength(methodNames)) %code.Write(", ")
    }
    Do %code.Write(")")
    Return $$$OK
}

ClassMethod IsValidDT(%val As %RawString) As %Status [ Final ]
{
    Return $ListFind($ClassMethod(..GetFqcn(), "GetValues"), %val) > 0
}

}
