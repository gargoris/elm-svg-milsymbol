module Main exposing (..)

import Html exposing (..)
import Svg as S exposing (..)
import Svg.Attributes as SA exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (onInput)


--import Html.Events exposing (onClick)

import PortsOfMil exposing (..)


-- MODEL


type alias Model =
    { cadena : String
    , svgs : Html Msg
    , status : Bool
    , drawingInst : Maybe (List DataMilDrawinInstructions)
    }


init : ( Model, Cmd Msg )
init =
    ( Model "Hello" (S.text "Hello") False Maybe.Nothing, Cmd.none )



-- MESSAGES


type Msg
    = NoOp
    | NewString String
    | NewSymbolSVG DataMilSymbol
    | Expand
    | Collapse



-- VIEW


view : Model -> Html Msg
view model =
    Html.form [ HA.class "form-horizontal" ]
        [ div [ HA.class "form-group" ]
            [ label [ HA.for "milSymbolCode", HA.class "" ] [ Html.text "Código" ]
            , input
                [ HA.id "milSymbolCode"
                , HA.attribute "aria-describedby" "emailHelp"
                , HA.class "form-control"
                , HA.type_ "text"
                , placeholder "MilSymbol code"
                , onInput NewString
                ]
                []

            --     div []
            --     [ Html.text model.cadena ]
            -- , if model.status then
            --     div []
            --         [ button [ onClick Collapse ] [ Html.text "Collapse" ]
            --         , Html.text model.cadena
            --         ]
            --   else
            --     div []
            --         [ button [ onClick Expand ] [ Html.text "Expand" ] ]
            --,
            , small
                [ HA.id "emailHelp"
                , HA.class "form-text text-muted"
                ]
                [ Html.text "Write your own symbol definition"
                ]
            ]
        , div [ HA.class "form-group" ]
            [ h4 []
                [ Html.text "The Symbol"
                ]
            ]
        , div [ HA.class "form-group" ]
            [ model.svgs
            ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        NewString a ->
            ( { model
                | cadena = a
              }
            , prepareSymbol a
            )

        NewSymbolSVG s ->
            ( { model
                | svgs = parseSVG s
                , drawingInst = Maybe.Just s.draws
              }
            , Cmd.none
            )

        Expand ->
            ( { model | status = True }
            , Cmd.none
            )

        Collapse ->
            ( { model | status = False }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    getSymbol NewSymbolSVG



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


parseSVG : DataMilSymbol -> Svg msg
parseSVG d =
    S.svg
        [ SA.version "1.1"
        , SA.x "0"
        , SA.y "0"
        , SA.width "640"
        , SA.height "480"
        ]
        (mapDrawingInstructions
            d.draws
        )


mapDrawingInstructions : List DataMilDrawinInstructions -> List (Svg msg)
mapDrawingInstructions d =
    List.map
        (\p ->
            S.text_
                [ SA.fontFamily "serif"
                , SA.fontSize "20"
                , SA.fill "#000000"
                , SA.id "svg_2"
                , SA.y "146"
                , SA.x "351"
                ]
                [ S.text p.symbolType ]
        )
        d



-- svg
--     [ version "1.1"
--     , x "0"
--     , y "0"
--     , viewBox "0 0 1000 1000"
--     ]
--     [ polygon [ fill "#F0AD00", points "161.649,152.782 231.514,82.916 91.783,82.916" ] []
--     , polygon [ fill "#7FD13B", points "8.867,0 79.241,70.375 232.213,70.375 161.838,0" ] []
--     , rect
--         [ fill "#7FD13B"
--         , x "192.99"
--         , y "107.392"
--         , SA.width "107.676"
--         , SA.height "108.167"
--         , transform "matrix(0.7071 0.7071 -0.7071 0.7071 186.4727 -127.2386)"
--         ]
--         []
--     , polygon [ fill "#60B5CC", points "323.298,143.724 323.298,0 179.573,0" ] []
--     , polygon [ fill "#5A6378", points "152.781,161.649 0,8.868 0,314.432" ] []
--     , polygon [ fill "#F0AD00", points "255.522,246.655 323.298,314.432 323.298,178.879" ] []
--     , polygon [ fill "#60B5CC", points "161.649,170.517 8.869,323.298 314.43,323.298" ] []
--     ]
