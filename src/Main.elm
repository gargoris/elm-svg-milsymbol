module Main exposing (..)

import Html exposing (..)
import Svg exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model svgMsg =
    { cadena : String
    , svgs : Svg svgMsg
    , status : Bool
    }


init : ( Model msg, Cmd Msg )
init =
    ( Model "Hello" (Svg.text "Hello") False, Cmd.none )



-- MESSAGES


type Msg
    = NoOp
    | NewString String
    | Expand
    | Collapse



-- VIEW


view : Model msg -> Html Msg
view model =
    div []
        [ div []
            [ Html.text model.cadena ]
        , if model.status then
            div []
                [ button [ onClick Collapse ] [ Html.text "Collapse" ]
                , Html.text model.cadena
                ]
          else
            div []
                [ button [ onClick Expand ] [ Html.text "Expand" ] ]
        ]



-- , div
--     []
--     [ model.svgs ]
-- ]
-- UPDATE


update : Msg -> Model msg -> ( Model msg, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        NewString a ->
            ( { model
                | cadena = a
                , svgs = Svg.text a
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


subscriptions : Model msg -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never (Model msg) Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
