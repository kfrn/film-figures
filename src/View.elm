module View exposing (view)

import Helpers exposing (displayNameForGauge, feetToMetres, formatDuration, getDisplayValue)
import Html exposing (Html, b, button, div, em, h1, i, input, label, nav, p, span, text)
import Html.Attributes as Attr exposing (attribute, class, classList, id, placeholder, step, type_, value)
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
        inFocus control =
            model.controlInFocus == control

        panel =
            case control of
                FootageControl ->
                    createFootageControlPanel model control (inFocus control)

                DurationControl ->
                    createDurationControlPanel model control (inFocus control)

                FrameCountControl ->
                    createFrameCountControlPanel model control (inFocus control)
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


createFootageControlPanel : Model -> Control -> Bool -> Html Msg
createFootageControlPanel model currentControl inFocus =
    let
        footage =
            case model.system of
                Metric ->
                    feetToMetres model.footage

                Imperial ->
                    model.footage

        footageVal =
            getDisplayValue footage 2

        nameStr =
            case model.system of
                Metric ->
                    MetresStr

                Imperial ->
                    FeetStr

        labelText =
            translate model.language nameStr
    in
    if inFocus then
        makeInputSection footageVal UpdateFootage labelText
    else
        makeInfoSection footageVal labelText


createDurationControlPanel : Model -> Control -> Bool -> Html Msg
createDurationControlPanel model currentControl inFocus =
    let
        duration =
            getDisplayValue model.duration 2

        labelText =
            case model.speed of
                -- TODO: temp. This will later become a selectable option.
                TwentyFourFPS ->
                    "@24fps"
    in
    if inFocus then
        makeInputSection duration UpdateDuration labelText
    else
        makeInfoSection (formatDuration model.duration) labelText


createFrameCountControlPanel : Model -> Control -> Bool -> Html Msg
createFrameCountControlPanel model currentControl inFocus =
    let
        frameCount =
            getDisplayValue model.frameCount 1

        labelText =
            translate model.language FramesStr
    in
    if inFocus then
        makeInputSection frameCount UpdateFrameCount labelText
    else
        makeInfoSection frameCount labelText


makeInputSection : String -> (String -> Msg) -> String -> Html Msg
makeInputSection paramValue message labelText =
    div [ class "field is-horizontal" ]
        [ div [ class "field-body" ]
            [ input
                [ classList [ ( "input", True ) ]
                , placeholder paramValue
                , type_ "number"
                , Attr.min "0"
                , step "0.01"
                , onInput message
                ]
                []
            ]
        , div [ class "field-label is-normal" ]
            [ label [ classList [ ( "label", True ) ] ] [ text labelText ]
            ]
        ]


makeInfoSection : String -> String -> Html Msg
makeInfoSection paramValue labelText =
    div [ class "field is-horizontal" ]
        [ div [ class "field-label param-value is-normal" ] [ b [] [ text paramValue ] ]
        , div [ class "field-label is-normal" ]
            [ label [] [ text labelText ]
            ]
        ]
