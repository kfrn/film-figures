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
    | UpdateFootage String
    | UpdateDuration String
    | UpdateFrameCount String
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

        ChangeGauge g ->
            let
                newModel =
                    { model | gauge = g }
            in
            ( newModel, Cmd.none )

        ChangeControlInFocus control ->
            let
                newModel =
                    { model | controlInFocus = control }
            in
            ( { newModel | controlInFocus = control }, Cmd.none )

        UpdateFootage footage ->
            case String.toFloat footage of
                Ok ft ->
                    let
                        ( dur, fc ) =
                            Calculate.fromFootage model.gauge ft

                        newModel =
                            { model | duration = Just dur, frameCount = Just fc, footage = Just ft }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateDuration duration ->
            case String.toFloat duration of
                Ok dur ->
                    let
                        ( fc, ft ) =
                            Calculate.fromDuration model.gauge dur

                        newModel =
                            { model | duration = Just dur, frameCount = Just fc, footage = Just ft }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateFrameCount framecount ->
            case String.toFloat framecount of
                Ok fc ->
                    let
                        ( dur, ft ) =
                            Calculate.fromFrameCount model.gauge fc

                        newModel =
                            { model | duration = Just dur, frameCount = Just fc, footage = Just ft }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
