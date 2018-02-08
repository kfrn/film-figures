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
    | UpdateFootage FootageInFeet
    | UpdateDuration DurationInSeconds
    | UpdateFrameCount FrameCount
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
            let
                newModel =
                    { model | controlInFocus = control }
            in
            ( { newModel | controlInFocus = control }, Cmd.none )

        UpdateFootage footage ->
            let
                ( dur, fc ) =
                    Calculate.fromFootage model.speed model.gauge footage

                newModel =
                    { model | duration = dur, frameCount = fc, footage = footage }
            in
            ( newModel, Cmd.none )

        UpdateDuration duration ->
            let
                ( fc, ft ) =
                    Calculate.fromDuration model.speed model.gauge duration

                newModel =
                    { model | duration = duration, frameCount = fc, footage = ft }
            in
            ( newModel, Cmd.none )

        UpdateFrameCount framecount ->
            let
                ( dur, ft ) =
                    Calculate.fromFrameCount model.speed model.gauge framecount

                newModel =
                    { model | duration = dur, frameCount = framecount, footage = ft }
            in
            ( newModel, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
