module Update exposing (Msg(..), update)

import Calculate
import Helpers exposing (conditionallyRound)
import Model exposing (Model)
import Translate exposing (Language(..))
import Types exposing (..)


type Msg
    = ChangeLanguage Language
    | ChangeSystemOfMeasurement SystemOfMeasurement
    | ChangeGauge Gauge
    | ChangeSpeed Speed
    | UpdateFootage String
    | UpdateDuration String
    | UpdateFrameCount String
    | ToggleMenu
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLanguage l ->
            ( { model | language = l }, Cmd.none )

        ChangeSystemOfMeasurement sys ->
            let
                newModel =
                    calculateFromFrameCount model model.frameCount sys
            in
            ( { newModel | system = sys }, Cmd.none )

        ChangeGauge filmGauge ->
            let
                newModel =
                    calculateFromFootage model model.footage filmGauge model.system model.speed
            in
            ( { newModel | gauge = filmGauge }, Cmd.none )

        ChangeSpeed speed ->
            let
                newModel =
                    calculateFromFootage model model.footage model.gauge model.system speed
            in
            ( { newModel | speed = speed }, Cmd.none )

        UpdateFootage footage ->
            let
                newModel =
                    calculateFromFootage model footage model.gauge model.system model.speed
            in
            ( newModel, Cmd.none )

        UpdateDuration duration ->
            case String.toFloat duration of
                Ok dur ->
                    let
                        ( fc, len ) =
                            Calculate.fromDuration model.system model.speed model.gauge dur

                        newModel =
                            { model
                                | duration = duration
                                , frameCount = conditionallyRound fc
                                , footage = conditionallyRound len
                            }
                    in
                    ( newModel, Cmd.none )

                Err _ ->
                    let
                        newModel =
                            clearFilmValues model
                    in
                    ( { newModel | duration = duration }, Cmd.none )

        UpdateFrameCount frameCount ->
            let
                newModel =
                    calculateFromFrameCount model frameCount model.system
            in
            ( newModel, Cmd.none )

        ToggleMenu ->
            let
                open =
                    model.dropdownMenuOpen
            in
            ( { model | dropdownMenuOpen = not open }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


clearFilmValues : Model -> Model
clearFilmValues model =
    { model
        | frameCount = ""
        , duration = ""
        , footage = ""
    }


calculateFromFootage : Model -> String -> Gauge -> SystemOfMeasurement -> Speed -> Model
calculateFromFootage model footage gauge system speed =
    case String.toFloat footage of
        Ok ft ->
            let
                filmLength =
                    abs ft

                ( dur, fc ) =
                    Calculate.fromFootage system speed gauge filmLength
            in
            { model
                | duration = conditionallyRound dur
                , frameCount = conditionallyRound fc
                , footage = footage
            }

        Err _ ->
            let
                newModel =
                    clearFilmValues model
            in
            { newModel | footage = footage }


calculateFromFrameCount : Model -> String -> SystemOfMeasurement -> Model
calculateFromFrameCount model frameCount system =
    case String.toFloat frameCount of
        Ok fc ->
            let
                ( dur, len ) =
                    Calculate.fromFrameCount system model.speed model.gauge (abs fc)
            in
            { model
                | duration = conditionallyRound dur
                , frameCount = frameCount
                , footage = conditionallyRound len
            }

        Err _ ->
            let
                newModel =
                    clearFilmValues model
            in
            { newModel | frameCount = frameCount }
