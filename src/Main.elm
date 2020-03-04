module Main exposing (Model, Msg(..), codeOfConduct, init, main, update, view)

import Browser exposing (UrlRequest)
import Browser.Dom
import Browser.Navigation
import Html exposing (Html, a, div, footer, h1, h2, h3, h5, iframe, img, li, main_, nav, p, section, span, text, ul)
import Html.Attributes exposing (alt, class, href, id, src, style, target, title)
import Html.Events exposing (onClick)
import Task
import List
import Url exposing (Url)
import String
import Maybe

type alias Speaker =
    {
    id: String
    , name: String
    , imgPath: String
    , imgPostion: String
    , bio: List (Html Msg)
    , talk: Talk
    , isKeyNote: Bool
    , isCoPresenter: Bool
    , social: List (Html Msg)
    }

type alias Talk =
    {
        name: String
       ,description: List (Html Msg)
    }


emma: Speaker
emma = {
               id = "emma-cunningham"
               , imgPath = "/images/speakers/emma.jpg"
               , imgPostion = "top center"
               , name =  "Emma Cunningham"
               , bio = [ p [] [text "Emma Cunningham is a formal semanticist turned software engineer who currently is interested in thinking about distributed systems, data pipeline tooling, data visualization, and optimizing queries both for speed and semantic value. As a former linguist, they often think about how expressive type systems, reliable error messaging, and higher order logic can help solve these concerns in a maintainable and scalable manner. As a human being, their passions are in cooperation, abolition, magic, fermentation, descriptivist grammars, and a just transition away from extractive economies."]]
               , talk = {
                    name = ""
                    , description = [
                        span [] []
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = True
               , social =  [
                   a [href "https://gitlab.com/emmacunningham", target "_blank"] [span [class "fab fa-gitlab"] []]
                   , a [href "https://twitter.com/emmatcu", target "_blank"] [span [class "fab fa-twitter"] []]
               ]
               }

yonatan: Speaker
yonatan = {
               id = "yonatan-kogan"
               , imgPath = "/images/speakers/yonatan.jpg"
               , imgPostion = "top center"
               , name =  "Yonatan Kogan"
               , bio = [ p [] [text "Yonatan is originally from San Francisco and now lives in Columbia, SC. He is a Senior Software Engineer at ActBlue, an online fundraising platform for Democratic candidates up and down the ballot, progressive organizations, and nonprofits. He previously worked at Tock, a Chicago-based restaurant reservations company, Optimizely, an A/B testing platform, and Romotive, a Sequoia-backed robotics startup. He is also a founding member of GenderAvenger, a community dedicated to ensuring women are represented in the public dialog."]
                         ,p [] [text "Outside of work, Yonatan enjoys cooking, biking, sci-fi, watching Jeopardy, and working to improve his community."]
                ]
               , talk = {
                    name = "Put Your Model in the Cloud"
                    ,description = [
                        p [] [text "Shared workspace applications need an agreed on view of the world that multiple clients can see and update simultaneously. In this talk we show how we used the Elm architecture in production to share a read/writable Elm model across multiple clients, with minimal server involvement."]
                    ]
               }
               , isCoPresenter = True
               , isKeyNote = False
               , social =  [
                    a [href "https://github.com/yjkogan", target "_blank"] [span [class "fab fa-github"] []]
                    , a [href "https://twitter.com/yjkogan", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

jacob: Speaker
jacob = {
               id = "jacob-matthews"
               , imgPath = "/images/speakers/jacob.jpg"
               , imgPostion = "50% 15%"
               , name =  "Jacob Matthews"
               , bio = [
                    p [] [text "Jacob Matthews is a senior staff software engineer at Tock. Before becoming a professional programmer, he was a computer scientist who studied functional programming. He gravitated to Elm as a way of combining these two interests. When he's not programming, Jacob likes performing improv and playing with his baby. "]
               ]
               , talk = {
                    name = "Put Your Model in the Cloud"
                    ,description = [
                        p [] [text "Shared workspace applications need an agreed on view of the world that multiple clients can see and update simultaneously. In this talk we show how we used the Elm architecture in production to share a read/writable Elm model across multiple clients, with minimal server involvement."]
                    ]
               }
               , isCoPresenter = True
               , isKeyNote = False
               , social =  [
                  a [href "https://twitter.com/jmatthews", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

jeremy: Speaker
jeremy = {
               id = "jeremy-fairbank"
               , imgPath = "/images/speakers/jeremy.jpg"
               , imgPostion = "50% 20%"
               , name =  "Jeremy Fairbank"
               , bio = [
                    p [] [
                        span [] [text "Jeremy Fairbank is the author of "]
                        , a [href "https://pragprog.com/book/jfelm/programming-elm", target "_blank"] [text "Programming Elm from the Pragmatic Programmers"]
                        , span [] [text ". He is a software engineer and consultant at Test Double, where he helps improve how the world builds software. He loves working in Elm whenever he has the opportunity and helping other engineers discover how awesome Elm is."]
                    ]
                    , p [] [text "Besides that, he enjoys running, hiking, singing, playing guitar, and relaxing on the beach."]
               ]
               , talk = {
                    name = "Building Elm Frameworks by Building Command Line Elm Apps"
                    ,description = [
                        p [] [text "Elm makes building web apps fun. What if building command line apps was the same? In this talk, discover a tool for making command line Elm apps that embraces The Elm Architecture and elm-ui-like layouts. More importantly, learn the challenges of making frameworks that adapt Elm to other contexts."]
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                    a [href "http://blog.jeremyfairbank.com", target "_blank"] [span [class "fa fa-globe"] []]
                    , a [href "https://twitter.com/elpapapollo", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

tom: Speaker
tom = {
               id = "tom-davies"
               , imgPath = "/images/speakers/tom.jpg"
               , imgPostion = "80% center"
               , name =  "Tom Davies"
               , bio = [
                    p [] [text "Tom is an engineer at Concordium, where he is working on an Elm-like programming language for their new blockchain. Tom believes in a holistic approach to software engineering which values good error messages and a healthy community as much as shipping new features."]
               ]
               , talk = {
                    name = "The Elm compiler: An Earnest Teammate"
                    ,description = [
                        p [] [text "The Elm compiler is really smart and generates code that runs super fast!"]
                        , p [] [text "In this talk I'll share my love for the compiler and give you a whirlwind tour of its inner workings and a taste of some of the neat tricks that it employs behind the scenes to make your experience as great as it is."]
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                   a [href "https://twitter.com/todavies5", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

dillon: Speaker
dillon = {
               id = "dillion-kearns"
               , imgPath = "/images/speakers/dillon.jpg"
               , imgPostion = "50% 15%"
               , name =  "Dillion Kearns"
               , bio = [
                    p [] [text "Dillon is the author of "
                        , a [href "https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest", target "_blank"] [text "elm-graphql"]
                        , span [] [text ", "]
                        , a [href "https://elm-pages.com/", target "_blank" ] [text "elm-pages"]
                        , span [] [text ", and most recently, an extensible markdown parser designed for Elm. As the founder of Incremental Elm Consulting, his mission is to set Elm teams up for success as their frontends grow. His philosophy is that \"if it's broken, your compiler should be the first to tell you.\""]
                    ]
                    ,p [] [text "Currently, he is focused on helping Chicago-based company HubTran as they grow their Elm codebase, as well as building out a set of tools to make Elm the best option available for JAMstack development!"]
                    ,p [] [text "In his free time, he loves backpacking and playing the piano."]
               ]
               , talk = {
                    name = "It Takes a Community to Build a Markdown Parser"
                    ,description = [
                        p [] [text "What makes a great Elm Package? A strong core concept, driven by disciplined vision. And a great execution, driven by thoughtful tests and tooling."]
                        , p [] [text "This talk will reveal the secret sauce of a markdown parsing library, which enhances both core ingredients: tapping into an awesome community."]
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                   a [href "https://incrementalelm.com", target "_blank"] [span [class "fa fa-globe"] []]
                   , a [href "https://twitter.com/dillontkearns", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

abadi: Speaker
abadi = {
               id = "abadi-kurniawan"
               , imgPath = "/images/speakers/abadi.jpg"
               , imgPostion = "top center"
               , name =  "Abadi Kurniawan"
               , bio = [
                    p [] [
                     span [] [text "Abadi is a full stack engineer at 1904labs, where he spends most of his innovation hours hacking on Elm and learning new programming languages. He's a co-organizer of the St. Louis Elm Meetup. He's the author of several Elm packages such as "]
                     , a [href "https://github.com/abadi199/datetimepicker/", target "_blank"] [text "DateTimePicker"]
                     , span [] [text ","]
                     , a [href "https://github.com/abadi199/elm-input-extra", target "_blank"] [text " Input Extra"]
                     , span [] [text ","]
                     , a [href "https://github.com/abadi199/elm-creditcard", target "_blank"] [text " Credit Card"]
                     , span [] [text ","]
                     , a [href "https://github.com/abadi199/intl-phone-input", target "_blank"] [text " Intl Phone Input"],
                     span [] [text "."]
                   ]
                   , p [] [text "In his free time, he enjoys playing Minecraft with his son, travelling, and watching movies with his family."]
               ]
               , talk = {
                    name = "Animation Without Code"
                    ,description = [
                        p [] [text "Building animations in Elm can be challenging. A simple transition animation between 2 pages in Elm requires keeping the model of both pages until the transition is finished. I will share my experiment of using web standards to create a simple animation system in Elm with very little amount of code."]
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                  a [href "https://github.com/abadi199", target "_blank"] [span [class "fab fa-github"] []]
                  , a [href "https://twitter.com/abadikurniawan", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

richard: Speaker
richard = {
               id = "richard-feldman"
               , imgPath = "/images/speakers/richard.jpg"
               , imgPostion = "top center"
               , name =  "Richard Feldman"
               , bio = [
                    p [] [text "Richard is the author of "
                        , a [href "https://www.manning.com/books/elm-in-action?a_aid=elm_in_action&a_bid=b15edc5c", target "_blank"] [text "Elm in Action"]
                        , span [] [text " from Manning Publications, and the instructor for the Frontend Masters Introduction to Elm and Advanced Elm workshops. When he’s not writing about Elm, teaching Elm, speaking about Elm, working on his Elm open-source projects, or using Elm professionally at NoRedInk, you can find him hosting the Philadelphia Elm meetup."]
                        ]
                   , p [] [text "Some have said he’s “into Elm,” but he’s not sure where they got that wild idea."]
               ]
               , talk = {
                    name = "Maintainable Performance Optimization in Elm"
                    ,description = [
                        p [] [text "Delightful software runs fast, but performance optimizations often reduce code clarity. How do we balance the two? How often should we use Html.Lazy? What about tricks like (x - y == 0)? How should performance considerations affect API design? This talk explores the tradeoffs around these decisions."]
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                   a [href "https://www.manning.com/books/elm-in-action?a_aid=elm_in_action&a_bid=b15edc5c", target "_blank"] [span [class "fa fa-globe"] []]
                   , a [href "https://twitter.com/dillontkearns", target "_blank"] [span [class "fab fa-twitter"] []]
                ]
               }

andy: Speaker
andy = {
               id = "andy-thompson"
               , imgPath = "/images/speakers/andy.jpg"
               , imgPostion = "top center"
               , name =  "Andy Thompson"
               , bio = [
                    p [] []
               ]
               , talk = {
                    name = ""
                    ,description = [
                        p [] []
                    ]
               }
               , isCoPresenter = False
               , isKeyNote = False
               , social =  [
                    span [] []
                ]
               }

speakers: List Speaker
speakers =
    [emma, tom, jeremy, richard, dillon, yonatan, abadi, jacob , andy]


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

speakerPath : String -> String
speakerPath speakerId =
    "/speakers/" ++ speakerId


view : Model -> Html Msg
view model =
    if model.url.path == codeOfConductPath then
        codeOfConduct

    else if model.url.path == sponsorshipPath then
        sponsorship

    else if String.contains "speakers" model.url.path then
        let
            speakerID: String
            speakerID =
                String.replace "/speakers/" ""  model.url.path

            queriedSpeaker: Maybe Speaker
            queriedSpeaker =
                List.head (List.filter (\aSpeaker -> aSpeaker.id == speakerID) speakers)
        in

        case queriedSpeaker of
            Just speaker ->
                speakerIndividualSection speaker
            Nothing ->
                mainContent
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


generateSpeakerColumn: Speaker -> Html Msg
generateSpeakerColumn speaker =
    let
        talkHiglightHTML: Html Msg
        talkHiglightHTML =
            if speaker.talk.name /= "" then
                a [href ("/speakers/" ++ speaker.id), target "_self", class "highlight talk"] [text speaker.talk.name]
            else
                span [] []
    in
    div [class "speaker columns"] [
        div [class "speaker__profile_img is-half column", style "background-image" ( "url(%PUBLIC_URL%" ++ speaker.imgPath ++ ")"), style "background-position" speaker.imgPostion, title speaker.name] [
            a [href ("/speakers/" ++ speaker.id), target "_self", class "speaker-link", title speaker.name] [],
            a [href ("/speakers/" ++ speaker.id), target "_self"] [
                h3 [] [text speaker.name]
            ]
        ]
        , div [class "speaker__bio is-half column"] [
            div [class "speaker__social"]  speaker.social
            , div [class "highlights"] [talkHiglightHTML, highlightsHTML speaker]
            , div [] speaker.talk.description
            ]
    ]

appendedSpeakerSectionColumn: Html Msg
appendedSpeakerSectionColumn =
    div [class "speaker columns"] [
        div [class "speaker__profile_img is-half column speaker__profile_img speaker__profile_img--appended", style "background-image" "url(%PUBLIC_URL%/images/curtains.jpg)", style "background-position" "50% 80%"] [
            h3 [] [text "Stay Tuned!"]
        ]
        , div [class "speaker__bio is-half column"] [
            div [class "highlights"] [span [class "highlight"] [text "More Speakers Coming Soon!"]]
            , p [] [text "We are happy to announce our current list of speakers, stay tuned for next slate of speakers and more information on the talks!"]
            , p [] [text "Want to see last year’s talks? Check out our ", a [href "https://www.youtube.com/elminthespring", target "_blank"] [text "Youtube channel!"]]
            ]
    ]

speakersContent : Html Msg
speakersContent =
    section
        [id "speakers"]
        [div [class "content"]
                [ h1 [class "callout left"] [text "Speakers"]
                 , div [class "speakers"] (List.append (List.map  generateSpeakerColumn speakers) [appendedSpeakerSectionColumn] )
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
                [ a [ href "https://www.youtube.com/elminthespring", target "_blank" ] [ text "2019 Talks" ]
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

speakerIndividualSection : Speaker -> Html Msg
speakerIndividualSection speaker =
    main_ [ class "page--stand-alone" ] [
        section
            [id "speakers", class "page--stand-alone__speaker"]
                        [div [class "content"]
                                [ h1 [class "callout stand-alone left"] [text speaker.name]
                                 , div [class "speakers"] [
                                    div [class "speaker stand-alone columns"] [
                                        div [class "speaker__bio is-full column"] [
                                            div [class "speaker__social"] speaker.social
                                            , div [class "highlights"] [ highlightsHTML speaker ]
                                            , div [] speaker.bio
                                            , h3 [] [text speaker.talk.name]
                                            , div [] speaker.talk.description

                                            ]
                                    ]
                                 ]
                                ]
                        ]
    ]


highlightsHTML: Speaker -> Html Msg
highlightsHTML speaker =
    if speaker.isCoPresenter then
        span [class "highlight info small"] [text "Co-Presenter"]
    else if speaker.isKeyNote then
        span [class "highlight"] [text "Keynote Speaker"]
    else
        span [] []

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
