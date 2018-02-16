module Helpers exposing (..)

import Round
import Types exposing (..)


displayNameForGauge : Gauge -> String
displayNameForGauge gauge =
    case gauge of
        ThirtyFive ->
            "35mm"

        TwentyEight ->
            "28mm"

        Sixteen ->
            "16mm"

        NinePtFive ->
            "9.5mm"


displayNameForSpeed : Speed -> String
displayNameForSpeed speed =
    case speed of
        SixteenFPS ->
            "16fps"

        EighteenFPS ->
            "18fps"

        TwentyFourFPS ->
            "24fps"

        TwentyFiveFPS ->
            "25fps"

        NtscFPS ->
            "29.97fps"


getDisplayValue : Float -> Int -> String
getDisplayValue val dp =
    if isWholeFloat val then
        toString <| floor val
    else
        Round.round dp val


isWholeFloat : Float -> Bool
isWholeFloat num =
    num - (toFloat <| floor num) == 0


feetToMetres : FootageInFeet -> FootageInMetres
feetToMetres feet =
    feet * 0.3048


metresToFeet : FootageInMetres -> FootageInFeet
metresToFeet metrage =
    metrage / 0.3048


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
