module Main exposing (..)

import Browser
import Html exposing (Html, text, span, div, h1, img, section, main_, h2)
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
            [ div
                [ class "intro__logo--flower" ]
                [ img [ src "%PUBLIC_URL%/images/eits-logo-flower.svg"  ] [] ]
            , div
                [ class "intro__logo--text" ]
                [ img [ src "%PUBLIC_URL%/images/eits-logo-text.svg" ] [] ]
            , div
                [ class "intro__details" ]
                [  h2
                    [ class "intro__date" ]
                    [ span [] [text "May 1, 2020"]
                    , span [] [text "\u{00A0}🌸\u{00A0}"]
                    , span [] [text "Chicago, IL"]
                    ]
                , div
                    [ class "intro__tagline" ] [ text "A day to learn, teach, and share about Elm!" ]
                ]
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
