module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, section, main_)
import Html.Attributes exposing (src, class)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    main_
        []
        [ section
            [ class "intro" ]
            [ div [ class "intro__logo--flower" ] []
            , div [ class "intro__logo--text" ] []
            , div
                [ class "intro__details" ]
                [ div [] []
                , div [] []
                , div [] []
                ]
            , div
                [ class "intro__tagline" ] []
            ]
        , section
            [ class "stay-tuned" ]
            [ div [] []
            , div [] []
            , div [] []
            ]
        ]




---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
