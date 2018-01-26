module View exposing (view)

import Html exposing (Html, div, em, h1, i, nav, p, span, text)
import Html.Attributes exposing (attribute, class, id)
import Model exposing (Model)
import Types exposing (..)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ navbar model.system
        , div [] [ text <| "content will go here" ]
        , footer
        ]


navbar : SystemOfMeasurement -> Html Msg
navbar system =
    nav [ class "navbar", attribute "role" "navigation" ]
        [ div [ class "navbar-brand" ]
            [ div [ class "navbar-item" ]
                [ p [ class "title" ]
                    [ span [ class "icon" ] [ i [ class "fa fa-film" ] [] ]
                    , span [ class "app-title" ] [ text "film figures" ]
                    ]
                ]
            ]
        , div [ class "navbar-menu" ]
            [ div [ class "navbar-start" ]
                [ div [ class "navbar-item" ]
                    [ p [ class "is-size-6" ] [ em [] [ text "a calculator for analogue film" ] ]
                    ]
                ]
            , div [ class "navbar-end" ] [ text "measurement controls here" ]
            ]
        ]


footer : Html Msg
footer =
    div [ class "level app-footer" ]
        [ div [ class "level-left" ] [ text "app by KFN" ]
        , div [ class "is-size-6" ] [ text "links here" ]
        ]
