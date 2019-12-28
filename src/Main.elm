module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, a, div, h1, h2, h3, h5, img, main_, section, span, text)
import Html.Attributes exposing (class, href, src)



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
                [ img [ src "%PUBLIC_URL%/images/eits-logo-flower.svg" ] [] ]
            , div
                [ class "intro__logo--text" ]
                [ img [ src "%PUBLIC_URL%/images/eits-logo-text.svg" ] [] ]
            , div
                [ class "intro__details" ]
                [ h2
                    [ class "intro__date" ]
                    [ span [] [ text "May 1, 2020" ]
                    , span [] [ text "\u{00A0}🌸\u{00A0}" ]
                    , span [] [ text "Chicago, IL" ]
                    ]
                , div
                    [ class "intro__tagline" ]
                    [ text "A day to learn, teach, and share about Elm!" ]
                ]
            ]
        , section
            [ class "content" ]
            [ div
                [ class "cfp" ]
                [ div []
                    [ text "If you want to share your experience and learnings with the community, we’d love to hear from you! We will have speaking slots specifically for first-time speakers." ]
                , div
                    [ class "cfp__link" ]
                    [ a
                        [ href "https://www.papercall.io/elm-in-the-spring-2020" ]
                        [ text "Submit Your Idea" ]
                    ]
                ]
            , h5
                [ class "stay-tuned__coming-soon", class "gradient-anim" ]
                [ text "More Details coming soon!"
                ]
            , div
                [ class "footer" ]
                [ a
                    [ href "https://2019.elminthespring.org/" ]
                    [ text "2019 Site" ]
                , text " | "
                , a
                    [ href "/code-of-conduct.md" ]
                    [ text "Code of Conduct" ]
                ]
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
