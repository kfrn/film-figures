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
    let
        feet =
            180

        sys =
            Imperial

        speed =
            TwentyFourFPS

        gauge =
            Sixteen

        ( dur, frames ) =
            Calculate.fromFootage sys speed gauge feet
    in
    { system = sys
    , language = EN
    , gauge = gauge
    , controlInFocus = FootageControl
    , duration = dur
    , frameCount = frames
    , footage = feet
    , speed = speed
    , dropdownMenuOpen = False
    }
