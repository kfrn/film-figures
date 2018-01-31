module View exposing (view)

import Helpers exposing (displayNameForGauge, getDisplayValue)
import Html exposing (Html, b, button, div, em, h1, i, input, label, nav, p, span, text)
import Html.Attributes as Attrs exposing (attribute, class, classList, id, min, placeholder, step, type_, value)
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

            -- , div [ class "navbar-end" ] [ systemControls language system, languageControls language ]
            , div [ class "navbar-end" ] [ languageControls language ]
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
    div [ id "calculator" ]
        [ div [ id "gauge", class "calculator" ]
            [ p [] [ text <| translate model.language GaugeStr ]
            , div [] (List.map makeGaugeButton allGauges)
            ]
        , div [ id "other-controls", class "calculator" ]
            [ p [] [ text <| translate model.language SetOptionStr ]
            , div [ class "columns" ]
                (List.map (makePanel model) allControls)
            ]
        ]


makePanel : Model -> Control -> Html Msg
makePanel model control =
    let
        duration =
            getDisplayValue model.duration 2

        footage =
            getDisplayValue model.footage 2

        frameCount =
            getDisplayValue model.frameCount 1

        inFocus control =
            model.controlInFocus == control

        panel =
            case control of
                FootageControl ->
                    let
                        labelText =
                            translate model.language FeetStr
                    in
                    if inFocus control then
                        makeInputSection footage UpdateFootage labelText "0.01"
                    else
                        makeInfoSection control model.controlInFocus footage labelText

                DurationControl ->
                    let
                        labelText =
                            translate model.language SecondsStr
                    in
                    if inFocus control then
                        makeInputSection duration UpdateDuration labelText "0.1"
                    else
                        makeInfoSection control model.controlInFocus duration labelText

                FrameCountControl ->
                    let
                        labelText =
                            translate model.language FramesStr
                    in
                    if inFocus control then
                        makeInputSection frameCount UpdateFrameCount labelText "1"
                    else
                        makeInfoSection control model.controlInFocus frameCount labelText
    in
    div
        [ classList
            [ ( "column", True )
            , ( "control-panel", True )
            , ( "control-focused", control == model.controlInFocus )
            , ( "control-unfocused", control /= model.controlInFocus )
            ]
        , onClick <| ChangeControlInFocus control
        ]
        [ panel ]


makeInputSection : String -> (String -> Msg) -> String -> String -> Html Msg
makeInputSection paramValue message labelText stepvalue =
    div [ class "field is-horizontal" ]
        [ div [ class "field-body" ]
            [ input
                [ classList [ ( "input", True ) ]
                , placeholder paramValue
                , type_ "number"
                , step stepvalue
                , Attrs.min "0"
                , onInput message
                ]
                []
            ]
        , div [ class "field-label is-normal" ]
            [ label [ classList [ ( "label", True ) ] ] [ text labelText ]
            ]
        ]


makeInfoSection : Control -> ControlInFocus -> String -> String -> Html Msg
makeInfoSection control controlInFocus paramValue labelText =
    div [ class "field is-horizontal" ]
        [ div [ class "field-label param-value is-normal" ] [ b [] [ text paramValue ] ]
        , div [ class "field-label is-normal" ]
            [ label [ classList [ ( "label", control == controlInFocus ) ] ] [ text labelText ]
            ]
        ]
