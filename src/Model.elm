module Model exposing (Model, init)

import Translate exposing (Language(..))
import Types exposing (..)


type alias Model =
    { language : Language
    , system : SystemOfMeasurement
    }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { language = EN
    , system = Imperial
    }
