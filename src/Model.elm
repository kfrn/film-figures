module Model exposing (Model, init)

import Translate exposing (Language(..))
import Types exposing (..)


type alias Model =
    { gauge : Gauge
    , language : Language
    , controlInFocus : Control
    , system : SystemOfMeasurement
    }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { gauge = ThirtyFive
    , language = EN
    , controlInFocus = LengthControl
    , system = Imperial
    }
