module View exposing (view)

import Helpers exposing (displayNameForGauge)
import Html exposing (Html, button, div, em, h1, i, input, label, nav, p, span, text)
import Html.Attributes exposing (attribute, class, classList, id, placeholder)
import Html.Events exposing (onClick, onInput)
import Links exposing (LinkName(..), link)
import Model exposing (Model)
import Translate exposing (AppString(..), Language(..), allLanguages, translate)
import Types exposing (..)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ navbar model.language model.system
        , calculator model

        -- , div [] [ text "results will go here" ]
        , footer model.language
        ]


navbar : Language -> SystemOfMeasurement -> Html Msg
navbar language system =
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
                    [ p [ class "is-size-6" ] [ em [] [ text <| translate language TaglineStr ] ]
                    ]
                ]
            , div [ class "navbar-end" ] [ systemControls language system, languageControls language ]
            ]
        ]


systemControls : Language -> SystemOfMeasurement -> Html Msg
systemControls lang system =
    let
        nameStr s =
            case s of
                Metric ->
                    MetricStr

                Imperial ->
                    ImperialStr

        makeButton sys =
            button
                [ classList
                    [ ( "button is-small", True )
                    , ( "is-primary", sys == system )
                    ]
                , onClick (ChangeSystemOfMeasurement sys)
                ]
                [ text <| translate lang <| nameStr sys ]
    in
    div [ class "navbar-item" ] (List.map makeButton allSystemsOfMeasurement)


languageControls : Language -> Html Msg
languageControls language =
    let
        makeButton l =
            button
                [ classList
                    [ ( "button is-small", True )
                    , ( "is-primary", l == language )
                    ]
                , onClick <| ChangeLanguage l
                ]
                [ text <| toString l ]
    in
    div [ class "navbar-item" ] (List.map makeButton allLanguages)


footer : Language -> Html Msg
footer language =
    div [ class "level app-footer" ]
        [ div [ class "level-left left-offset" ] [ text <| translate language DevelopedByStr ]
        , div [ class "is-size-6 right-offset" ] [ link Email, link SourceCode ]
        ]


calculator : Model -> Html Msg
calculator model =
    let
        makeGaugeButton g =
            button
                [ classList
                    [ ( "button", True )
                    , ( "is-primary", g == model.gauge )
                    ]
                , onClick <| ChangeGauge g
                ]
                [ text <| displayNameForGauge g ]
    in
    div [ id "calculator", class "left-offset right-offset" ]
        [ div [ id "gauge", class "calculator" ]
            [ p [] [ text "Your film reel is:" ]
            , div [] (List.map makeGaugeButton allGauges)
            ]
        , div [ id "other-controls", class "calculator" ]
            [ p [] [ text "Set one of the following:" ]
            , div [ class "columns" ]
                (List.map (makeControl model.controlInFocus) allControls)
            ]
        ]


makeControl : ControlInFocus -> Control -> Html Msg
makeControl controlInFocus control =
    let
        makeInputSection placeholderText message labelText =
            div [ class "field" ]
                [ input
                    [ classList [ ( "input", True ) ]
                    , placeholder placeholderText
                    , onInput message
                    ]
                    []
                , p [ classList [ ( "label", control == controlInFocus ) ] ] [ text labelText ]
                ]

        inputSection =
            case control of
                LengthControl ->
                    makeInputSection "400" UpdateLength "feet"

                DurationControl ->
                    makeInputSection "360" UpdateDuration "seconds"

                FrameCountControl ->
                    makeInputSection "320" UpdateFrameCount "frames"
    in
    div
        [ classList
            [ ( "column", True )
            , ( "control-panel", True )
            , ( "control-focused", control == controlInFocus )
            , ( "control-unfocused", control /= controlInFocus )
            ]
        , onClick <| ChangeControlInFocus control
        ]
        [ inputSection ]
