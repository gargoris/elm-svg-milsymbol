module MilSymbolProcess exposing (..)

import PortsOfMil exposing (..)
import Dict exposing (..)


type alias DataMilDrawinInsInner =
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


type alias DataMilInnerSymbol =
    { draws : List DataMilDrawinInsInner
    , props : Maybe DataMilSymbolPropertiesInner
    }


type alias DataMilSymbolPropertiesInner =
    DataMilSymbolProperties



-- The temporary result


convert : DataMilDrawinInstructions -> Dict Int DataMilDrawinInsInner -> Dict Int DataMilDrawinInsInner
convert i d =
    let
        m =
            get i.id d
    in
        case m of
            Just a ->
                d

            Nothing ->
                d



-- here be dragons: recibe a DataMilSymbol from outside and return a datamilsymbol correctly "indented"


transformInner : DataMilSymbol -> Maybe DataMilInnerSymbol
transformInner d =
    --foldl : (a -> b -> b) -> b -> List a -> b
    Nothing
