module MilSymbolProcess exposing (..)

import PortsOfMil exposing (..)
import Dict exposing (..)


type SortedDrawingInstruction
    = SortedDrawingInstruction
        { id : Int
        , inst : DrawingInstruction
        }


type DrawingInstruction
    = Translate
        { x : Float
        , y : Float
        , draw : List SortedDrawingInstruction
        }
    | Rotate
        { degree : Float
        , x : Float
        , y : Float
        , draw : List SortedDrawingInstruction
        }
    | Scale
        { factor : Float
        , draw : List SortedDrawingInstruction
        }
    | Path
        { -- SVG path data
          d : String
        , -- Fill color  or set to false if none
          fill : String
        , -- Fill opacity {Optional}
          fillopacity : Maybe Float
        , -- Stroke color  or set to false if none
          stroke : String
        , -- {Optional}
          strokedasharray : Maybe String
        , --Width of the stroke {Optional}
          strokewidth : Maybe Float
        }
    | Circle
        { cx : Float
        , cy : Float
        , r : Float
        , -- Fill color  or set to false if none
          fill : String
        , -- Fill opacity {Optional}
          fillopacity : Maybe Float
        , -- Stroke color  or set to false if none
          stroke : String
        , -- {Optional}
          strokedasharray : Maybe String
        , --Width of the stroke {Optional}
          strokewidth : Maybe Float
        }
    | Text
        { x : Float
        , y : Float
        , textanchor : String
        , fontsize : Float
        , fontfamily : String
        , fontweight : String
        , -- Fill color  or set to false if none
          fill : String
        , -- Fill opacity {Optional}
          fillopacity : Maybe Float
        , -- Stroke color  or set to false if none
          stroke : String
        , -- {Optional}
          strokedasharray : Maybe String
        , --Width of the stroke {Optional}
          strokewidth : Maybe Float
        }
    | Svg
        { svg : String
        }


type alias DataMilSymbol =
    { draws : List SortedDrawingInstruction
    , props : Maybe DataMilSymbolPropertiesInner
    }


type alias DataMilSymbolPropertiesInner =
    DataMilSymbolPropertiesPort



-- The temporary result


convert : DataMilDrawinInstructionsPort -> Dict Int SortedDrawingInstruction -> Dict Int SortedDrawingInstruction
convert i d =
    let
        m =
            get i.id d

        parent =
            case i.drawParent of
                Just p ->
                    get p d

                Nothing ->
                    Nothing
    in
        case m of
            Just a ->
                d

            Nothing ->
                d



-- here be dragons: recibe a DataMilSymbol from outside and return a datamilsymbol correctly "indented"


transformInner : DataMilSymbolPort -> Maybe DataMilSymbol
transformInner d =
    --foldl : (a -> b -> b) -> b -> List a -> b
    Nothing
