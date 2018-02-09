module View exposing (view)

import Helpers exposing (displayNameForGauge, formatDuration, getDisplayValue)
import Html exposing (Html, b, button, div, em, h1, i, input, label, nav, p, span, text)
import Html.Attributes as Attr exposing (attribute, class, classList, id, placeholder, required, step, type_, value)
import Html.Events exposing (onClick, onInput, onWithOptions)
import Json.Decode as Decode
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
                        makeInputSection control footage UpdateFootage labelText
                    else
                        makeInfoSection control model.controlInFocus footage labelText

                DurationControl ->
                    let
                        duration =
                            formatDuration model.duration

                        labelText =
                            case model.speed of
                                TwentyFourFPS ->
                                    "@24fps" -- TODO: temp. This will later become a selectable option.
                    in
                    if inFocus control then
                        makeInputSection control duration UpdateDuration labelText
                    else
                        makeInfoSection control model.controlInFocus duration labelText

                FrameCountControl ->
                    let
                        labelText =
                            translate model.language FramesStr
                    in
                    if inFocus control then
                        makeInputSection control frameCount UpdateFrameCount labelText
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


makeInputSection : Control -> String -> (String -> Msg) -> String -> Html Msg
makeInputSection control paramValue message labelText =
    let
        ( inputType, stepVal ) =
            case control of
                DurationControl ->
                    ( "time", "1" )

                _ ->
                    ( "number", "0.01" )
    in
    div [ class "field is-horizontal" ]
        [ div [ class "field-body" ]
            [ input
                [ classList [ ( "input", True ) ]
                , placeholder paramValue
                , type_ inputType
                , step stepVal
                , required True
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
        [ div
            [ class "field-label param-value is-normal"
            , onClickParamValue Update.NoOp
            ]
            [ b [] [ text paramValue ] ]
        , div [ class "field-label is-normal" ]
            [ label [ classList [ ( "label", control == controlInFocus ) ] ] [ text labelText ]
            ]
        ]


onClickParamValue : Msg -> Html.Attribute Msg
onClickParamValue msg =
    let
        options =
            { stopPropagation = True
            , preventDefault = False
            }
    in
    onWithOptions "click" options (Decode.succeed msg)
