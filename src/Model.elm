module Model exposing (Model, init)

import Calculate exposing (fromFootage)
import Translate exposing (Language(..))
import Types exposing (..)


type alias Model =
    { system : SystemOfMeasurement
    , language : Language
    , gauge : Gauge
    , duration : String
    , frameCount : String
    , footage : String
    , speed : Speed
    , dropdownMenuOpen : Bool
    }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    let
        system =
            Imperial

        speed =
            TwentyFourFPS

        gauge =
            Sixteen

        footage =
            24

        ( duration, frames ) =
            fromFootage system speed gauge footage
    in
    { system = system
    , language = EN
    , gauge = gauge
    , footage = toString footage
    , duration = toString duration
    , frameCount = toString frames
    , speed = speed
    , dropdownMenuOpen = False
    }
