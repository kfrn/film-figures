module Model exposing (Model, init)

import Translate exposing (Language(..))
import Types exposing (..)


type alias Model =
    { system : SystemOfMeasurement
    , language : Language
    , gauge : Gauge
    , controlInFocus : Control
    , duration : Maybe DurationInSeconds
    , frameCount : Maybe FrameCount
    , length : Maybe LengthInFeet
    }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { system = Imperial
    , language = EN
    , gauge = ThirtyFive
    , controlInFocus = LengthControl
    , duration = Nothing
    , frameCount = Nothing
    , length = Nothing
    }
