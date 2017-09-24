port module PortsOfMil exposing (..)

-- A DataMilSymbol is a description for a svg node, with a lot of redundant data...


type alias DrawProperties =
    { fill : String
    , fillopacity : Maybe Float
    , stroke : String
    , strokewidth : Maybe Float
    , strokedasharray : Maybe String
    }


type alias DataMilDrawinInstructions =
    { id : Int
    , symbolType : String
    , path : String
    , cx : Float
    , cy : Float
    , r : Float
    , x : Float
    , y : Float
    , degree : Float
    , textAnchor : String
    , fontSize : Float
    , fontFamily : String
    , fontweight : String
    , factor : Float
    , dP : DrawProperties
    , linecap : String
    , drawParent : Maybe Int -- maybe this instruction is child of a transformation
    , svg : Maybe String
    }


type alias DataMilSymbol =
    { draws : List DataMilDrawinInstructions
    , props : Maybe DataMilSymbolProperties
    }


type alias BaseGeometry =
    { g : TypeG
    , bbox : BoundingBox
    }


type alias TypeG =
    { d : String
    , typeG : String
    }


type alias BoundingBox =
    { x1 : Float
    , x2 : Float
    , y1 : Float
    , y2 : Float
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
