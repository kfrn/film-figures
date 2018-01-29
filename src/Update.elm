module Update exposing (Msg(..), update)

import Model exposing (Model)
import Translate exposing (Language(..))
import Types exposing (..)


type Msg
    = ChangeLanguage Language
    | ChangeSystemOfMeasurement SystemOfMeasurement
    | ChangeGauge Gauge
    | ChangeControlInFocus Control
    | UpdateLength String
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
            ( { model | gauge = g }, Cmd.none )

        ChangeControlInFocus control ->
            ( { model | controlInFocus = control }, Cmd.none )

        UpdateLength len ->
            case String.toFloat len of
                Ok l ->
                    let
                        newModel =
                            { model | length = Just l }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateDuration duration ->
            case String.toFloat duration of
                Ok d ->
                    let
                        newModel =
                            { model | duration = Just d }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateFrameCount framecount ->
            case String.toFloat framecount of
                Ok fc ->
                    let
                        newModel =
                            { model | frameCount = Just fc }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
