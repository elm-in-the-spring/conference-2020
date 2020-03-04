module Route exposing (Route(..), fromUrl, href, toString)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Maybe.Extra as Maybe
import Url exposing (Url)
import Url.Builder exposing (Root(..))
import Url.Parser as Parser exposing ((</>), Parser, fragment, s, top)


type alias SectionId =
    Maybe String


type Route
    = Root
    | NotFound
    | Home SectionId
    | Sponsorship
    | CodeOfConduct


toString : Route -> String
toString route =
    case route of
        Root ->
            "/"

        NotFound ->
            toString Root

        Home sectionId ->
            Maybe.unwrap
                (toString Root)
                (Url.Builder.custom Relative [] [])
                (Just sectionId)

        Sponsorship ->
            "/sponsorship"

        CodeOfConduct ->
            "/code-of-conduct"


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Root top
        , Parser.map Home (top </> fragment identity)
        , Parser.map Sponsorship (s "sponsorship")
        , Parser.map CodeOfConduct (s "code-of-conduct")
        ]


fromUrl : Url -> Route
fromUrl url =
    Parser.parse parser url
        |> Maybe.withDefault Root


href : Route -> Attribute msg
href targetRoute =
    Attr.href (toString targetRoute)
