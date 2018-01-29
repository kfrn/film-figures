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
    , footage : Maybe FootageInFeet
    }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { system = Imperial
    , language = EN
    , gauge = ThirtyFive
    , controlInFocus = FootageControl
    , duration = Nothing
    , frameCount = Nothing
    , footage = Nothing
    }
