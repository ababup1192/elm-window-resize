port module Main exposing (main)

import Browser
import Browser.Dom as Dom
import Browser.Events exposing (onResize)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task as Task



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { logoSize : Float
    , isResized : Bool
    , viewportWidth : Float
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { logoSize = 10.0, isResized = False, viewportWidth = 0.0 }, Task.perform GotViewport Dom.getViewport )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = Increment
    | Decrement
    | NoticeWindowResize Int Int
    | GotViewport Dom.Viewport


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { logoSize } =
            model
    in
    case msg of
        Increment ->
            ( { model | logoSize = logoSize + 0.2 }, Cmd.none )

        Decrement ->
            ( { model | logoSize = logoSize - 0.2 }, Cmd.none )

        NoticeWindowResize w _ ->
            ( { model | viewportWidth = toFloat w }, Cmd.none )

        GotViewport { viewport } ->
            ( { model | viewportWidth = viewport.width }, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    let
        { viewportWidth } =
            model
    in
    { title = "Elm window resize"
    , body =
        [ header [ class "site-header" ]
            [ h1 [] [ text "Elm window resize" ]
            ]
        , main_ []
            [ p [] [ text <| "width: " ++ String.fromFloat viewportWidth ]
            ]
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onResize NoticeWindowResize
        ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
