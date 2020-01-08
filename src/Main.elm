module Main exposing (Model, Msg(..), codeOfConduct, init, main, update, view)

import Browser exposing (UrlRequest)
import Browser.Dom
import Browser.Navigation
import Html exposing (Html, a, div, footer, h1, h2, h3, h5, iframe, img, li, main_, nav, p, section, span, text, ul)
import Html.Attributes exposing (alt, class, href, id, src, style, target)
import Html.Events exposing (onClick)
import Task
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
    | ScrollTo String
    | NoOp


scrollTo : Float -> Float -> Cmd Msg
scrollTo x y =
    Task.attempt (\_ -> NoOp) (Browser.Dom.setViewport x y)

scrollToById : String -> Cmd Msg
scrollToById id =
    Browser.Dom.getElement id
      |> Task.andThen (\info -> Browser.Dom.setViewport 0 info.element.y)
      |> Task.attempt (\_ -> NoOp)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlRequest _ ->
            ( model, Cmd.none )

        OnUrlChange url ->
            ( { model | url = url }, Cmd.none )

        NavigateTo urlString ->
            ( model, Cmd.batch [ scrollTo 0.0 0.0 , Browser.Navigation.pushUrl model.navigationKey urlString] )

        ScrollTo id ->
            ( model
            , Cmd.batch
                [
                    Browser.Navigation.pushUrl model.navigationKey ("../#" ++ id)
                    , scrollToById id
                ]
            )

        NoOp ->
             ( model, Cmd.none )

---- VIEW ----


codeOfConductPath : String
codeOfConductPath =
    "/code-of-conduct"


sponsorshipPath : String
sponsorshipPath =
    "/sponsorship"


view : Model -> Html Msg
view model =
    if model.url.path == codeOfConductPath then
        codeOfConduct

    else if model.url.path == sponsorshipPath then
        sponsorship

    else
        mainContent


mainContent : Html Msg
mainContent =
    main_
        [ ]
        [ navigationContent
        , homeContent
        , detailsContent
        , divider
        , grantsInfoSection
        , divider
        , newsletterContent
        , divider
        , speakersContent
        , divider
        , sponsorsContent
        , divider
        , footerContent
        ]


homeContent : Html Msg
homeContent =
    section
        [ id "home" ]
        [ div [ class "hero__headline" ]
            [ h1 [ class "a11y-hidden" ] [ text "Elm In the Spring 2020" ]
            , img [ src "%PUBLIC_URL%/images/hero-logo.png", alt "Elm In the Spring" ] []
            ]
        , div [ class "ribbon" ] [ text "Chicago ❀ May 1, 2020" ]
        ]


detailsContent : Html Msg
detailsContent =
    section
        [ id "details" ]
        [ div [ class "content" ]
            [ h1 [ class "callout right" ] [ text "Details" ]
            , div [ class "copy" ]
                [ h2 [] [ text "All Elm, all day!" ]
                , p [] [ text "Elm in the Spring is a single-track, single-day conference for developers who love Elm. Whether you’re an Elm expert scaling up your production app or you're just starting out with your first Elm project, join us for a great day of learning, teaching, and community" ]
                , p [] [ text "Elm in the Spring 2020 will take place on Friday, May 1st at the ", a [ href "https://www.google.com/maps?q=Newberry+Library+Chicago", target "_blank", class "animate" ] [ text "Newberry Library" ], span [] [ text " in Chicago." ] ]
                , p [] [ text "All attendees are expected to observe the conference ", a [ href codeOfConductPath, onClick (NavigateTo codeOfConductPath), class "animate" ] [ text "Code of Conduct" ], span [] [ text "." ] ]
                , a [ class "btn btn--yellow", href "https://ti.to/elm-in-the-spring/chicago-2020/", target "_blank" ] [ text "Get Your Tickets" ]
                ]
            ]
        ]


grantsInfoSection : Html Msg
grantsInfoSection =
    section
        [ id "grants", class "container" ]
        [ h1 [] [ text "Conference Grants" ]
        , p [] [ text "We strive to be an inclusive, accessible, and welcoming community. To help break down the barriers that prevent diversity in technology, we are excited to provide conference grants. If you would like to attend the conference but are not able to due to financial circumstances, please fill out the ", a [ href "https://forms.gle/wJZYRRoxTcbGvuti9", target "_blank", class "animate blue" ] [ text "grant form" ], span [] [ text "." ] ]
        ]


speakersContent : Html Msg
speakersContent =
    section
        [id "speakers"]
        [div [class "content"]
                [ h1 [class "callout left"] [text "Speakers"]
                 , div [class "speakers"] [
                    --div [class "speaker columns"] [
                    --    div [class "speaker__profile_img is-half column", style "background-image" "url(%PUBLIC_URL%/images/speakers/emma.jpg)", style "background-position" "top center"] [
                    --        h3 [] [text "Emma Cunningham"]
                    --    ]
                    --    , div [class "speaker__bio is-half column"] [
                    --        div [class "speaker__social"]  [
                    --            a [href "#"] [span [class "fab fa-github"] []]
                    --            ,a [href "#"] [span [class "fab fa-twitter"] []]
                    --            ,a [href "#"] [span [class "fas fa-globe"] []]
                    --        ]
                    --        , div [class "highlights"] [span [class "highlight talk"] [text "Customizing Browsers with Elm"]]
                    --        , p [] [text "Emma Cunningham is a formal semanticist turned software engineer who currently is interested in thinking about distributed systems, data pipeline tooling, data visualization, and query optimization. As a former linguist, they often think about how expressive type systems, reliable error messaging, and higher order logic can help solve these concerns in a maintainable and scalable manner. When they’re not cranking out code, Emma practices sleight-of-hand magic and ferments all kinds of things in their hometown of Los Angeles."]
                    --        ]
                    --]
                    div [class "speaker columns"] [
                        div [class "speaker__profile_img is-half column", style "background-image" "url(%PUBLIC_URL%/images/curtains.jpg)", style "background-position" "50% 80%"] [
                            h3 [] [text "You?"]
                        ]
                        , div [class "speaker__bio is-half column"] [
                            div [class "highlights"] [span [class "highlight talk"] [text "Coming Soon!"]]
                            , p [] [text "Want to share your idea? ", a [href "https://www.papercall.io/elm-in-the-spring-2020", target "_blank"] [text "Submit a talk!"]]
                            , p [] [text "Elm in the Spring welcomes new and seasoned speakers to give a talk in Chicago! Each talk slot is 30 minutes. We’re reserving a minimum of two (2) talk spots for first-time speakers."]
                            , p [] [text "Want to see last year’s talks? Check out our ", a [href "https://www.youtube.com/elminthespring", target "_blank"] [text "Youtube channel!"]]
                            ]
                    ]
                 ]
                ]
        ]


sponsorsContent : Html Msg
sponsorsContent =
    section
        [ id "sponsors" ]
        [ div [ class "content" ]
            [ h1 [ class "callout right" ] [ text "Sponsors" ]
            , div [ class "copy" ]
                [ h2 [] [ text "Thank you to our Sponsors" ]
                , p [] [ text "Without the support, involvement, and enthusiasm of generous sponsors and supporters, Elm in the Spring would not be possible . You or your company can become a sponsor for Elm in the Spring 2020. For more info, check out ", a [ href sponsorshipPath, onClick (NavigateTo sponsorshipPath), class "animate black" ] [ text " becoming a sponsor." ] ]
                ]
            , div [ class "sponsors columns" ]
                [ div [ class "sponsor column is-one-third" ] [ img [ src "%PUBLIC_URL%/images/sponsors/espark-logo.svg", alt "eSpark Learning" ] [] ]
                , div [ class "sponsor column is-one-third" ] [ img [ src "%PUBLIC_URL%/images/sponsors/hubtran-logo.svg", alt "Hubtran" ] [] ]
                , div [ class "sponsor column is-one-third" ] [ img [ src "%PUBLIC_URL%/images/sponsors/spantree-logo.svg", alt "eSpark Learning" ] [] ]
                ]
            ]
        ]


navigationContent : Html Msg
navigationContent =
    nav
        [ class "menu" ]
        [ ul []
            [ li []
                [ a [ href "#details", onClick (ScrollTo "details") ] [ text "Details" ]
                ]
            , li []
                [ a [ href "#speakers", onClick (ScrollTo "speakers") ] [ text "Speakers" ]
                ]
            , li []
                [ a [ href "https://www.papercall.io/elm-in-the-spring-2020", target "_blank" ] [ text "Submit A Talk" ]
                ]
            ]
        ]


newsletterContent : Html Msg
newsletterContent =
    section
        [ id "newsletter" ]
        [ div [ class "content" ]
            [ h1 [] [ text "Stay In Touch" ]
            , p [] [ text "For  conference updates, join our mailing list. No spam. Ever." ]
            , iframe [ src "https://smithsa.github.io/newsletter/" ] []
            , p [] [ text "Or, follow ", a [ href "https://twitter.com/elminthespring?lang=en", target "_blank", class "animate" ] [ text "@elminthespring" ], span [] [ text " on Twitter" ] ]
            ]
        ]


divider : Html Msg
divider =
    div [ class "divider--hatched" ] []


footerContent : Html Msg
footerContent =
    footer []
        [ div [ class "footer__content columns" ]
            [ div [ class "column" ] [ p [] [ text "© Elm in the Spring 2020" ] ]
            , div [ class "column" ]
                [ a [ href "https://github.com/elm-in-the-spring/conference-2020", target "_blank", class "open-source-note" ]
                    [ img [ src "%PUBLIC_URL%/images/open-source-note.svg", alt "This site is open source and built in Elm" ] []
                    ]
                ]
            ]
        ]


standAlonePageHeader : Html Msg
standAlonePageHeader =
    div [ class "hero" ]
        [ div [ class "logo-container" ]
            [ a [ href "./#home", onClick (NavigateTo "./#home") ] [ img [ src "%PUBLIC_URL%/images/hero-logo.png", alt "Elm In the Spring", class "logo" ] [] ] ]
        , navigationContent
        ]


wrapContentInStandAlonePage : Html Msg -> Html Msg
wrapContentInStandAlonePage innerHtml =
    div []
        [ standAlonePageHeader
        , divider
        , innerHtml
        , divider
        , footerContent
        ]


codeOfConduct : Html Msg
codeOfConduct =
    main_ [ class "page--stand-alone" ]
        [ wrapContentInStandAlonePage
            (div [ class "container container--wrapper" ]
                [ h1 [ id "conference-code-of-conduct" ] [ text "Conference Code of Conduct" ]
                , p [] [ text "All attendees, speakers, sponsors and volunteers at our conference are required to agree with the following code of conduct. Organisers will enforce this code throughout the event. We expect cooperation from all participants to help ensure a safe environment for everybody." ]
                , h2 [ id "need-help" ] [ text "Need Help?" ]
                , p []
                    [ text "In advance of the conference, please contact the organizing team at "
                    , a [ href "mailto:hello@elminthespring.org", target "_blank", class "animate black" ] [ text "hello@elminthespring.org" ]
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
                , p [] [ text " Conference staff can be identified as they'll be wearing branded clothing and/or badges. " ]
                , p [] [ text "Conference staff will be happy to help participants contact hotel/venue security or local law enforcement, provide escorts, or otherwise assist those experiencing harassment to feel safe for the duration of the conference. We value your attendance. " ]
                , p [] [ text "We expect participants to follow these rules at conference and workshop venues and conference-related social events." ]
                ]
            )
        ]


sponsorship : Html Msg
sponsorship =
    main_ [ class "page--stand-alone" ]
        [ wrapContentInStandAlonePage
            (div [ class "container container--wrapper" ]
                [ h1 [] [ text "Sponsorship" ]
                , p [] [ text "Interested in supporting the community? Sponsor Elm in the Spring! Contact us at ", a [ href "mailto:hello@elminthespring.org", target "_blank", class "animate black" ] [ text "hello@elminthespring.org" ], span [] [ text " for more information." ] ]
                , h2 [] [ text "Old Grove" ]
                , p [] [ text "Price: $2,500" ]
                , ul []
                    [ li [] [ text "20% discount on ticket purchases" ]
                    , li [] [ text "On-stage banner and speaker introduction opportunity. Limited space, first come first served!" ]
                    , li [] [ text "Logo included in videos and displayed on presentation screen between talks" ]
                    ]
                , h2 [] [ text "Shade Tree" ]
                , p [] [ text "Price: $1,000" ]
                , ul []
                    [ li [] [ text "15% discount on ticket purchases" ]
                    , li [] [ text "Special thank-you from the organizers during announcements" ]
                    , li [] [ text "Logo displayed on presentation screen between talks" ]
                    ]
                , h2 [] [ text "Spring Sapling" ]
                , p [] [ text "Price: $500" ]
                , ul []
                    [ li [] [ text "10% discount on ticket purchases" ]
                    ]
                ]
            )
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
