module Helpers exposing (..)

import Types exposing (..)


displayNameForGauge : Gauge -> String
displayNameForGauge gauge =
    case gauge of
        ThirtyFive ->
            "35mm"

        Sixteen ->
            "16mm"


displayNameForControl : Control -> String
displayNameForControl control =
    case control of
        LengthControl ->
            "length"

        DurationControl ->
            "duration"

        FrameCountControl ->
            "frame count"
