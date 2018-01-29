module View exposing (view)

import Helpers exposing (displayNameForGauge, getDisplayValue)
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
        , div [ id "app" ]
            [ calculator model
            , results model
            ]
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
            [ p [] [ text "Your film reel is:" ]
            , div [] (List.map makeGaugeButton allGauges)
            ]
        , div [ id "other-controls", class "calculator" ]
            [ p [] [ text "Set one of the following:" ]
            , div [ class "columns" ]
                (List.map (makeControl model) allControls)
            ]
        ]


makeControl : Model -> Control -> Html Msg
makeControl model control =
    let
        makeInputSection placeholderText message labelText =
            div [ class "field is-horizontal" ]
                [ div [ class "field-body" ]
                    [ input
                            [ classList [ ( "input", True ) ]
                            , placeholder placeholderText
                            , onInput message
                            ]
                            []
                    ]
                , div [ class "field-label is-normal" ]
                    [ label [ classList [ ( "label", True ) ] ] [ text labelText ]
                    ]
                ]

        inputSection =
            case control of
                FootageControl ->
                    let
                        placeholderValue =
                            -- case model.footage of
                            --     Just ft ->
                            --         Round.round 2 ft
                            --
                            --     Nothing ->
                            "-"
                    in
                    makeInputSection placeholderValue UpdateFootage "feet"

                DurationControl ->
                    let
                        placeholderValue =
                            -- case model.duration of
                            --     Just dur ->
                            --         Round.round 2 dur
                            --
                            --     Nothing ->
                            "-"
                    in
                    makeInputSection placeholderValue UpdateDuration "seconds"

                FrameCountControl ->
                    let
                        placeholderValue =
                            -- case model.frameCount of
                            --     Just fc ->
                            --         Round.round 1 fc
                            --
                            --     Nothing ->
                            "-"
                    in
                    makeInputSection placeholderValue UpdateFrameCount "frames"
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
        [ inputSection ]


results : Model -> Html Msg
results model =
    case ( model.duration, model.frameCount, model.footage ) of
        ( Just dur, Just fc, Just ft ) ->
            let
                duration =
                    getDisplayValue dur 2

                footage =
                    getDisplayValue ft 1

                frameCount =
                    getDisplayValue fc 1
            in
            div [ class "columns" ]
                [ div [ class "column" ] [ text <| footage ++ " ft" ]
                , div [ class "column" ] [ text <| duration ++ " seconds" ]
                , div [ class "column" ] [ text <| frameCount ++ " frames" ]
                ]

        ( _, _, _ ) ->
            div [] []
