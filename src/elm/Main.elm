module Main exposing (..)

import Html exposing (..)
import Svg as S exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (onInput)


--import Html.Events exposing (onClick)

import PortsOfMil exposing (DataMilSymbol, prepareSymbol, getSymbol)


-- MODEL


type alias Model =
    { cadena : String
    , svgs : Html Msg
    , status : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model "Hello" (S.text "Hello") False, Cmd.none )



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
    div []
        [ label [ HA.for "milSymbolCode" ] [ Html.text "Código" ]
        , input
            [ HA.id "milSymbolCode", type_ "text", placeholder "MilSymbol code", onInput NewString ]
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
        , model.svgs
        ]



-- , div
--     []
--     [ model.svgs ]
-- ]
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
    S.text d.path
