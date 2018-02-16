module Update exposing (Msg(..), update)

import Calculate
import Helpers exposing (metresToFeet)
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

        ChangeSystemOfMeasurement system ->
            case system of
                Metric ->
                    ( { model | system = Metric }, Cmd.none )

                Imperial ->
                    ( { model | system = Imperial }, Cmd.none )

        ChangeGauge filmGauge ->
            case model.controlInFocus of
                FootageControl ->
                    let
                        ( dur, fc ) =
                            Calculate.fromFootage model.speed filmGauge model.footage

                        newModel =
                            { model | gauge = filmGauge, duration = dur, frameCount = fc, footage = model.footage }
                    in
                    ( newModel, Cmd.none )

                DurationControl ->
                    let
                        ( fc, ft ) =
                            Calculate.fromDuration model.speed filmGauge model.duration

                        newModel =
                            { model | gauge = filmGauge, duration = model.duration, frameCount = fc, footage = ft }
                    in
                    ( newModel, Cmd.none )

                FrameCountControl ->
                    let
                        ( dur, ft ) =
                            Calculate.fromFrameCount model.speed filmGauge model.frameCount

                        newModel =
                            { model | gauge = filmGauge, duration = dur, frameCount = model.frameCount, footage = ft }
                    in
                    ( newModel, Cmd.none )

        ChangeControlInFocus control ->
            ( { model | controlInFocus = control }, Cmd.none )

        ChangeSpeed speed ->
            let
                ( dur, fc ) =
                    Calculate.fromFootage speed model.gauge model.footage

                newModel =
                    { model | duration = dur, frameCount = fc, speed = speed }
            in
            ( newModel, Cmd.none )

        UpdateFootage footage ->
            case String.toFloat footage of
                Ok ft ->
                    let
                        footage =
                            case model.system of
                                Imperial ->
                                    abs ft

                                Metric ->
                                    metresToFeet <| abs ft

                        ( dur, fc ) =
                            Calculate.fromFootage model.speed model.gauge footage

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

                            ( fc, ft ) =
                                Calculate.fromDuration model.speed model.gauge totalSeconds

                            newModel =
                                { model | duration = totalSeconds, frameCount = fc, footage = ft }
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
                        ( dur, ft ) =
                            Calculate.fromFrameCount model.speed model.gauge (abs fc)

                        newModel =
                            { model | duration = dur, frameCount = abs fc, footage = ft }
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
