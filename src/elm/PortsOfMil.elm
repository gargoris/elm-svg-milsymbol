port module PortsOfMil exposing (..)

-- A DataMilSymbol is a description for a svg node, with a lot of redundant data...


type alias DataMilDrawinInstructions =
    { id : Int
    , symbolType : String
    , path : String
    , cx : Float
    , cy : Float
    , r : Float
    , x : String
    , y : String
    , degree : String
    , textAnchor : String
    , fontSize : String
    , fontFamily : String
    , fontweight : String
    , factor : Float
    , stroke : String
    , strokewidth : String
    , strokedasharray : String
    , linecap : String
    , fill : String
    , fillopacity : String
    , drawChild : Int -- If the type is a transformation, here will be the id of inner node
    }


type alias DataMilSymbol =
    { draws : List DataMilDrawinInstructions
    , props : DataMilSymbolProperties
    }


type alias BaseGeometry =
    { affiliation : String
    , -- Affiliation it belongs to (Friend/Hostile...)
      baseAffilation : String
    , -- Dimension it belongs to (Air/Ground...)
      baseDimension : String
    , -- Dimension it is shown as (Air/Ground...) for example Ground Equipment is shown with the same shape as Sea.
      dimension : String
    , -- Is the dimension unknown
      dimensionUnknown : Bool
    }


type alias DataMilSymbolProperties =
    { -- Is it an Activity
      activity : Bool
    , -- Affiliation it is shown as (Friend/Hostile...)
      affiliation : String
    , -- Affiliation it belongs to (Friend/Hostile...)
      baseAffilation : String
    , -- Dimension it belongs to (Air/Ground...)
      baseDimension : String
    , -- Geometry is a combination of dimension and affiliation (AirFriend/GroundHostile...)
      baseGeometry : BaseGeometry
    , -- Is it Civilian
      civilian : Bool
    , -- What condition is it in
      condition : String
    , -- Context of the symbol (Reality/Exercise...)
      context : String
    , -- Dimension it is shown as (Air/Ground...) for example Ground Equipment is shown with the same shape as Sea.
      dimension : String
    , -- Is the dimension unknown
      dimensionUnknown : Bool
    , --What echelon (Platoon/Company...)
      echelon : String
    , -- Is it a Faker
      faker : Bool
    , -- Is it a feint/dummy
      fenintDummy : Bool
    , -- Standard says it should be filled
      fill : Bool
    , -- Standard says it should be framed
      frame : Bool
    , -- Part of SIDC referring to the icon.
      functionid : String
    , -- Is it a Headquarters
      headquarters : Bool
    , -- Is it an Instalation
      installation : Bool
    , -- Is it a Joker
      joker : Bool
    , -- What mobility (Tracked/Sled...)
      mobility : String
    , -- Is it Anticipated or Pending
      notpresent : String
    , -- Is the SIDC number based
      numberSIDC : Bool
    , -- Is it in Space
      space : Bool
    , -- Is it a task force
      taskForce : Bool
    }



-- So when we need a new symbol, we send its definition (as a string) to the milSymbol library in the other side of the wall


port prepareSymbol : String -> Cmd msg



-- ...and when the symbol is ready, we can receive it for parse and SVG creation in the elm side of the wall


port getSymbol : (DataMilSymbol -> msg) -> Sub msg
