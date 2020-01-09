module Main exposing (Model, Msg(..), codeOfConduct, init, main, update, view)

import Browser exposing (UrlRequest)
import Browser.Navigation
import Html exposing (Html, a, div, h1, h2, h3, h5, img, main_, p, section, span, text)
import Html.Attributes exposing (class, href, id, src, target)
import Html.Events exposing (onClick)
import Url exposing (Url)



---- MODEL ----


type alias Model =
    { navigationKey : Browser.Navigation.Key
    , url : Url
    }


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { navigationKey = key, url = url }, Cmd.none )



---- UPDATE ----


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
    | NavigateTo String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlRequest _ ->
            ( model, Cmd.none )

        OnUrlChange url ->
            ( { model | url = url }, Cmd.none )

        NavigateTo urlString ->
            ( model, Browser.Navigation.pushUrl model.navigationKey urlString )



---- VIEW ----


codeOfConductPath : String
codeOfConductPath =
    "/code-of-conduct"


view : Model -> Html Msg
view model =
    if model.url.path == codeOfConductPath then
        codeOfConduct

    else
        mainContent


mainContent : Html Msg
mainContent =
    main_
        [ id "splash-page" ]
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
            [ class "stay-tuned" ]
            [ h3
                [ class "stay-tuned__coming-soon" ]
                [ text "More details "
                , span [ class "gradient-anim" ] [ text " coming soon!" ]
                ]
            , div
                [ class "footer" ]
                [ a [ href "https://www.papercall.io/elm-in-the-spring-2020", target "_blank" ]
                    [ text "CFP" ]
                , text " | "
                , a
                    [ onClick (NavigateTo codeOfConductPath), href codeOfConductPath ]
                    [ text "Code of Conduct" ]
                , text " | "
                , a
                    [ href "https://2019.elminthespring.org/", target "_blank" ]
                    [ text "2019 Site" ]
                ]
            ]
        ]


codeOfConduct : Html Msg
codeOfConduct =
    main_ [ id "code-of-conduct" ]
        [ h1 [ id "conference-code-of-conduct" ] [ text "Conference Code of Conduct" ]
        , p []
            [ a [ onClick (NavigateTo "/"), href "/" ] [ text "back" ]
            ]
        , p [] [ text "All attendees, speakers, sponsors and volunteers at our conference are required to agree with the following code of conduct. Organisers will enforce this code throughout the event. We expect cooperation from all participants to help ensure a safe environment for everybody." ]
        , h2 [ id "need-help" ] [ text "Need Help?" ]
        , p []
            [ text "In advance of the conference, please contact the organizing team at "
            , a [ href "mailto:hello@elminthespring.org" ] [ text "hello@elminthespring.org" ]
            , text " any time you need help or have questions or concerns. In the weeks before the conference, we’ll send out direct contact info for the organizers so you can reach out to us in real time via text, phone, or Twitter."
            ]
        , h2 [ id "the-quick-version" ] [ text "The Quick Version" ]
        , p [] [ text "Our conference is dedicated to providing a harassment-free conference experience for everyone, regardless of gender, gender identity and expression, age, sexual orientation, disability, physical appearance, body size, race, ethnicity, religion (or lack thereof), or technology choices. We do not tolerate harassment of conference participants in any form. Sexual language and imagery is not appropriate for any conference venue, including talks, workshops, parties, Twitter and other online media. Conference participants violating these rules may be sanctioned or expelled from the conference without a refund at the discretion of the conference organisers." ]
        , h2 [ id "the-less-quick-version" ] [ text "The Less Quick Version" ]
        , p [] [ text "Harassment includes offensive verbal comments related to gender, gender identity and expression, age, sexual orientation, disability, physical appearance, body size, race, ethnicity, religion, technology choices, sexual images in public spaces, deliberate intimidation, stalking, following, harassing photography or recording, sustained disruption of talks or other events, inappropriate physical contact, and unwelcome sexual attention. " ]
        , p [] [ text "Participants asked to stop any harassing behavior are expected to comply immediately. " ]
        , p [] [ text "Sponsors are also subject to the anti-harassment policy. In particular, sponsors should not use sexualised images, activities, or other material. Booth staff (including volunteers) should not use sexualised clothing/uniforms/costumes, or otherwise create a sexualised environment. " ]
        , p [] [ text "If a participant engages in harassing behavior, the conference organisers may take any action they deem appropriate, including warning the offender or expulsion from the conference with no refund. " ]
        , p []
            [ text "If you are being harassed, notice that someone else is being harassed, or have any other concerns, please contact a member of conference staff immediately." ]
        , p [] [ text " Conference staff can be identified as they&#39;ll be wearing branded clothing and/or badges. " ]
        , p [] [ text "Conference staff will be happy to help participants contact hotel/venue security or local law enforcement, provide escorts, or otherwise assist those experiencing harassment to feel safe for the duration of the conference. We value your attendance. " ]
        , p [] [ text "We expect participants to follow these rules at conference and workshop venues and conference-related social events." ]
        , p []
            [ a [ onClick (NavigateTo "/"), href "/" ] [ text "back" ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view =
            \model ->
                { title = "Elm in the Spring"
                , body = [ view model ]
                }
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
