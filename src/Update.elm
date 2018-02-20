module Update exposing (Msg(..), update)

import Calculate
import Model exposing (Model)
import Translate exposing (Language(..))
import Types exposing (..)


type Msg
    = ChangeLanguage Language
    | ChangeSystemOfMeasurement SystemOfMeasurement
    | ChangeGauge Gauge
    | ChangeControlInFocus Control
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
            if sys == model.system then
                ( model, Cmd.none )
            else
                case model.controlInFocus of
                    FootageControl ->
                        let
                            ( dur, fc ) =
                                Calculate.fromFootage sys model.speed model.gauge model.footage

                            newModel =
                                { model | system = sys, duration = dur, frameCount = fc }
                        in
                        ( newModel, Cmd.none )

                    DurationControl ->
                        let
                            ( fc, len ) =
                                Calculate.fromDuration sys model.speed model.gauge model.duration

                            newModel =
                                { model | system = sys, frameCount = fc, footage = len }
                        in
                        ( newModel, Cmd.none )

                    FrameCountControl ->
                        let
                            ( dur, len ) =
                                Calculate.fromFrameCount sys model.speed model.gauge model.frameCount

                            newModel =
                                { model | system = sys, duration = dur, footage = len }
                        in
                        ( newModel, Cmd.none )

        ChangeGauge filmGauge ->
            case model.controlInFocus of
                FootageControl ->
                    let
                        ( dur, fc ) =
                            Calculate.fromFootage model.system model.speed filmGauge model.footage

                        newModel =
                            { model | gauge = filmGauge, duration = dur, frameCount = fc }
                    in
                    ( newModel, Cmd.none )

                DurationControl ->
                    let
                        ( fc, len ) =
                            Calculate.fromDuration model.system model.speed filmGauge model.duration

                        newModel =
                            { model | gauge = filmGauge, frameCount = fc, footage = len }
                    in
                    ( newModel, Cmd.none )

                FrameCountControl ->
                    let
                        ( dur, len ) =
                            Calculate.fromFrameCount model.system model.speed filmGauge model.frameCount

                        newModel =
                            { model | gauge = filmGauge, duration = dur, footage = len }
                    in
                    ( newModel, Cmd.none )

        ChangeControlInFocus control ->
            ( { model | controlInFocus = control }, Cmd.none )

        ChangeSpeed speed ->
            let
                ( dur, fc ) =
                    Calculate.fromFootage model.system speed model.gauge model.footage

                newModel =
                    { model | duration = dur, frameCount = fc, speed = speed }
            in
            ( newModel, Cmd.none )

        UpdateFootage footage ->
            case String.toFloat footage of
                Ok ft ->
                    let
                        footage =
                            abs ft

                        ( dur, fc ) =
                            Calculate.fromFootage model.system model.speed model.gauge footage

                        newModel =
                            { model | duration = dur, frameCount = fc, footage = footage }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateDuration duration ->
            let
                numStrings =
                    String.split ":" duration
            in
            if List.length numStrings == 3 then
                case List.map String.toInt numStrings of
                    [ Ok hrs, Ok mins, Ok secs ] ->
                        let
                            totalSeconds =
                                toFloat <| secs + (mins * 60) + (hrs * 3600)

                            ( fc, len ) =
                                Calculate.fromDuration model.system model.speed model.gauge totalSeconds

                            newModel =
                                { model | duration = totalSeconds, frameCount = fc, footage = len }
                        in
                        ( newModel, Cmd.none )

                    _ ->
                        ( model, Cmd.none )
            else
                ( model, Cmd.none )

        UpdateFrameCount framecount ->
            case String.toFloat framecount of
                Ok fc ->
                    let
                        ( dur, len ) =
                            Calculate.fromFrameCount model.system model.speed model.gauge (abs fc)

                        newModel =
                            { model | duration = dur, frameCount = abs fc, footage = len }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        ToggleMenu ->
            let
                open =
                    model.dropdownMenuOpen
            in
            ( { model | dropdownMenuOpen = not open }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
