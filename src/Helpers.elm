module Helpers exposing (..)

import Types exposing (..)


displayNameForGauge : Gauge -> String
displayNameForGauge gauge =
    case gauge of
        ThirtyFive ->
            "35mm"

        Sixteen ->
            "16mm"
