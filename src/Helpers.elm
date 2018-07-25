module Helpers exposing (..)

import Round
import Types exposing (..)


displayNameForGauge : Gauge -> String
displayNameForGauge gauge =
    case gauge of
        Imax ->
            "Imax"

        Seventy ->
            "65mm/70mm (5-perf)"

        ThirtyFive ->
            "35mm"

        ThirtyFiveThreePerf ->
            "35mm 3-perf"

        ThirtyFiveTwoPerf ->
            "35mm 2-perf"

        TwentyEight ->
            "28mm"

        SeventeenPtFive ->
            "17.5mm"

        Sixteen ->
            "16mm"

        NinePtFive ->
            "9.5mm"

        SuperEight ->
            "Super-8"

        Eight ->
            "8mm"


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


isWholeFloat : Float -> Bool
isWholeFloat num =
    num - (toFloat <| floor num) == 0


conditionallyRound : Float -> String
conditionallyRound num =
    if isWholeFloat num then
        toString num
    else
        Round.round 3 num
