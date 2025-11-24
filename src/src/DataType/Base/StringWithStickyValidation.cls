/// %String with validation independent of the parameters defined in %String level
Class DataType.Base.StringWithStickyValidation Extends %String [ Abstract ]
{

Parameter MAXLEN;

ClassMethod IsValid(%val As %RawString) As %Status [ CodeMode = generator, Final, ServerOnly = 0 ]
{
    #; This datatype is validated by IsValidDT and also %String normal validation (This differs from %String).
    $$$GENERATE("    Quit:('##class("_%class_")."_$$$QN(%property_"IsValidDT")_"(%val)) $$$ERROR($$$DTFailure,%val)")
    #; Validate MAXLEN parameter - either NULL, "", or a positive integer
    If ($Get(%parameter("MAXLEN")) '= "") && (('$IsValidNum(%parameter("MAXLEN"),,1)) || (((+%parameter("MAXLEN")\1)) '= +%parameter("MAXLEN"))) { Quit $$$ERROR($$$DatatypeParameterIntegerNotPositive,%class_"::"_%property,"MAXLEN",%parameter("MAXLEN")) }
    If %parameter("VALUELIST")'="" Do   Quit $$$OK
    . Set sep=$Extract(%parameter("VALUELIST")) ;for now
    . $$$GENERATE("    Q $s(%val'["""_sep_"""&&("_$$$quote(%parameter("VALUELIST")_sep)_"[("""_sep_"""_$select(%val=$c(0):"""",1:%val)_"""_sep_""")):$$$OK,1:$$$ERROR($$$DTValueList,%val,"_$$$quote(%parameter("VALUELIST"))_"))")
    Set str="",err=""
    If %parameter("MINLEN")'="" {
        Set str=str_"($s(%val'=$c(0):$l(%val),1:0)'<"_(+%parameter("MINLEN"))_")"
        If %parameter("PATTERN")="",%parameter("MAXLEN")=""||(%parameter("TRUNCATE")) {
            Set err="1"
        } Else {
            Set err="$s(%val'=$c(0):$l(%val),1:0)<"_(+%parameter("MINLEN"))
        }
        Set err=err_":$$$ERROR($$$DTMinLen,%val,"_(+%parameter("MINLEN"))_")"
    }
    If '%parameter("TRUNCATE"),%parameter("MAXLEN")'="" {
        Set str=str_"&&($l(%val)'>"_(+%parameter("MAXLEN"))_")"
        If %parameter("PATTERN")="" {
            Set err=err_$Select(err="":"",1:",")_"1"
        } Else {
            Set err=err_$Select(err="":"",1:",")_"$l(%val)>"_(+%parameter("MAXLEN"))
        }
        Set err=err_":$$$ERROR($$$DTMaxLen,%val,"_(+%parameter("MAXLEN"))_")"
    }
    If %parameter("PATTERN")'="" Set str=str_"&&(%val?"_%parameter("PATTERN")_")",err=err_$Select(err="":"",1:",")_"1:$$$ERROR($$$DTPattern,%val,"_$$$quote(%parameter("PATTERN"))_")"
    If str="" $$$GENERATE("    Q 1") Quit $$$OK
    If $Extract(str,1,2)="&&" Set str=$Extract(str,3,*)
    $$$GENERATE("    Q $s("_str_":1,"_err_")")
    Quit $$$OK
}

/// Validation independent of the parameters defined in %String level
ClassMethod IsValidDT(%val As %RawString) As %Status [ Abstract ]
{
}

}
