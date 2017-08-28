module Main exposing (..)

import Html exposing (..)
import Svg exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model t =
    { cadena : String
    , svgs : Svg t
    , status : Bool
    }


init : ( Model t, Cmd t )
init =
    ( Model "Hello" (Svg.text "Hello") False, Cmd.none )



-- MESSAGES


type Msg
    = NoOp
    | NewString String
    | Expand
    | Collapse



-- VIEW


view : Model t -> Html t
view model =
    div []
        [ --     div []
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
          model.svgs
        ]



-- , div
--     []
--     [ model.svgs ]
-- ]
-- UPDATE


update : Msg -> Model t -> ( Model t, Cmd t )
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


subscriptions : Model t -> Sub t
subscriptions model =
    Sub.none



-- MAIN


main : Program Never (Model Msg) Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
