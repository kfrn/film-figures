module Helpers exposing (..)

import Round
import Types exposing (..)


displayNameForGauge : Gauge -> String
displayNameForGauge gauge =
    case gauge of
        ThirtyFive ->
            "35mm"

        Sixteen ->
            "16mm"


getDisplayValue : Float -> Int -> String
getDisplayValue val dp =
    if isWholeFloat val then
        toString <| floor val
    else
        Round.round dp val


isWholeFloat : Float -> Bool
isWholeFloat num =
    num - (toFloat <| floor num) == 0
