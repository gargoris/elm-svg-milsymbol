port module PortsOfMil exposing (..)

-- A DataMilSymbol is a description for a svg node.


type alias DataMilSymbol =
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
    , drawChild : Int -- If the type is a transformation, here will be the inner node
    }



-- So when we need a new symbol, we send its definition (as a string) to the milSymbol library in the other side of the wall


port prepareSymbol : String -> Cmd msg



-- ...and when the symbol is ready, we can receive it for parse and SVG creation in the elm side of the wall


port getSymbol : (DataMilSymbol -> msg) -> Sub msg
