module Helpers exposing (..)

import Maybe.Extra as MaybeX
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


formatDuration : DurationInSeconds -> String
formatDuration totalSeconds =
    let
        intSeconds =
            round totalSeconds

        padNumber num =
            if num < 10 then
                "0" ++ toString num
            else
                toString num

        hours =
            intSeconds // 3600

        minutes =
            (intSeconds - (hours * 3600)) // 60

        seconds =
            intSeconds % 60
    in
    padNumber hours ++ ":" ++ padNumber minutes ++ ":" ++ padNumber seconds
