module Model exposing (Model, init)

import Calculate
import Translate exposing (Language(..))
import Types exposing (..)


type alias Model =
    { system : SystemOfMeasurement
    , language : Language
    , gauge : Gauge
    , controlInFocus : Control
    , duration : DurationInSeconds
    , frameCount : FrameCount
    , footage : Footage
    , speed : Speed
    , dropdownMenuOpen : Bool
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
    , duration = 120
    , frameCount = 2880
    , footage = 180
    , speed = TwentyFourFPS
    , dropdownMenuOpen = False
    }
