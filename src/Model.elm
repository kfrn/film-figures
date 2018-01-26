module Model exposing (Model, init)

import Types exposing (..)


type alias Model =
    { system : SystemOfMeasurement }


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { system = Imperial
    }
