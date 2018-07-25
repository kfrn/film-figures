module View exposing (view)

-- import Calculate exposing (feetToMetres)

import Helpers exposing (displayNameForGauge, displayNameForSpeed)
import Html exposing (Html, button, div, em, i, input, nav, option, p, select, span, text)
import Html.Attributes exposing (attribute, class, classList, id, placeholder, selected, type_, value)
import Html.Events exposing (on, onClick, onInput)
import Json.Decode as Json
import Links exposing (LinkName(..), link)
import List.Extra as ListX
import Model exposing (Model)
import Translate exposing (AppString(..), Language(..), allLanguages, translate)
import Types exposing (..)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ navbar model.language model.system model.dropdownMenuOpen
        , calculator model
        , footer model.language
        ]


navbar : Language -> SystemOfMeasurement -> Bool -> Html Msg
navbar language system menuOpen =
    nav [ class "navbar", attribute "role" "navigation" ]
        [ div [ class "navbar-brand" ]
            [ div [ class "navbar-item" ]
                [ p [ class "title" ]
                    [ span [ class "icon" ] [ i [ class "fa fa-film" ] [] ]
                    , span [ class "app-title" ] [ text "film figures" ]
                    ]
                ]
            , div [ class "navbar-item app-tagline" ]
                [ p [ class "is-size-6" ] [ em [] [ text <| translate language TaglineStr ] ]
                ]
            , div
                [ classList [ ( "button navbar-burger", True ), ( "is-active", menuOpen ) ]
                , onClick ToggleMenu
                ]
                [ span [] []
                , span [] []
                , span [] []
                ]
            ]
        , div
            [ classList [ ( "navbar-menu", True ), ( "is-active", menuOpen ) ] ]
            [ div [ class "navbar-end" ] [ systemControls language system, languageControls language ]
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
    div [ id "calculator" ]
        [ div [ id "basics", class "calculator" ]
            [ p [] [ text <| translate model.language ChooseStr ]
            , div [ id "options" ]
                [ renderSelect model.gauge ChangeGauge displayNameForGauge allGauges
                , renderSelect model.speed ChangeSpeed displayNameForSpeed allSpeeds
                ]
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
        footageLabel =
            case model.system of
                Metric ->
                    "metres"

                Imperial ->
                    "feet"

        ( message, paramValue, labelText ) =
            case control of
                FootageControl ->
                    ( UpdateFootage, model.footage, footageLabel )

                DurationControl ->
                    ( UpdateDuration, model.duration, "seconds" )

                FrameCountControl ->
                    ( UpdateFrameCount, model.frameCount, "frames" )

        valid =
            (Result.toMaybe <| String.toFloat paramValue) == Nothing
    in
    div
        [ classList
            [ ( "column", True )
            , ( "control-panel", True )
            ]
        ]
        [ div
            [ class "field is-horizontal" ]
            [ div
                [ class "field-body" ]
                [ input
                    [ classList
                        [ ( "input", True )
                        , ( "is-primary", True )
                        , ( "is-danger", valid )
                        ]
                    , placeholder labelText
                    , type_ "text"
                    , value paramValue
                    , onInput message
                    ]
                    []
                ]
            , div
                [ class "field-label is-normal" ]
                [ text labelText ]
            ]
        ]


renderSelect : a -> (a -> Update.Msg) -> (a -> String) -> List a -> Html Update.Msg
renderSelect selectedOption message makeOptionName options =
    let
        makeOptionTag opt =
            option
                [ selected <| selectedOption == opt ]
                [ text <| makeOptionName opt ]

        displayNameToMsg displayName =
            case ListX.find (\item -> makeOptionName item == displayName) options of
                Just opt ->
                    message opt

                Nothing ->
                    Update.NoOp
    in
    div [ class "select" ]
        [ select [ onChange displayNameToMsg ] (List.map makeOptionTag options)
        ]


onChange : (String -> msg) -> Html.Attribute msg
onChange makeMessage =
    on "change" (Json.map makeMessage Html.Events.targetValue)
