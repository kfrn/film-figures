module Links exposing (..)

import Html exposing (Html, a, i, span)
import Html.Attributes exposing (class, href)


type LinkName
    = Email
    | SourceCode


link : LinkName -> Html msg
link name =
    case name of
        Email ->
            a [ href "mailto:kfnagels@gmail.com" ]
                [ span [ class "icon is-medium" ]
                    [ i [ class "fa fa-envelope has-text-primary" ] []
                    ]
                ]

        SourceCode ->
            a [ href "https://github.com/kfrn/film-figures" ]
                [ span [ class "icon" ]
                    [ i [ class "fa fa-github has-text-primary" ] []
                    ]
                ]
