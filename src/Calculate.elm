module Calculate exposing (..)

import Types exposing (..)


fromFootage : Gauge -> FootageInFeet -> ( DurationInSeconds, FrameCount )
fromFootage gauge footage =
    case gauge of
        ThirtyFive ->
            let
                frames =
                    footage * 16
            in
            ( frames / 24, frames )

        Sixteen ->
            let
                frames =
                    footage * 40
            in
            ( frames / 24, frames )


fromFrameCount : Gauge -> FrameCount -> ( DurationInSeconds, FootageInFeet )
fromFrameCount gauge framecount =
    case gauge of
        ThirtyFive ->
            ( framecount / 24, framecount / 16 )

        Sixteen ->
            ( framecount / 24, framecount / 40 )


fromDuration : Gauge -> DurationInSeconds -> ( FrameCount, FootageInFeet )
fromDuration gauge duration =
    let
        framecount =
            duration * 24
    in
    case gauge of
        ThirtyFive ->
            ( framecount, framecount / 16 )

        Sixteen ->
            ( framecount, framecount / 40 )
