module Update exposing (Msg(..), update)

import Model exposing (Model)
import Translate exposing (Language(..))
import Types exposing (Control(..), Gauge(..), SystemOfMeasurement(..))


type Msg
    = ChangeLanguage Language
    | ChangeSystemOfMeasurement SystemOfMeasurement
    | ChangeGauge Gauge
    | ChangeControlInFocus Control
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

        NoOp ->
            ( model, Cmd.none )
