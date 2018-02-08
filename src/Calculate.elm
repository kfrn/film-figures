module Calculate exposing (..)

import Types exposing (..)


fromFootage : Speed -> Gauge -> FootageInFeet -> ( DurationInSeconds, FrameCount )
fromFootage speed gauge footage =
    let
        frames =
            footage * framesPerFoot gauge
    in
    ( frames / speedInFPS speed, frames )


fromFrameCount : Speed -> Gauge -> FrameCount -> ( DurationInSeconds, FootageInFeet )
fromFrameCount speed gauge framecount =
    ( framecount / speedInFPS speed, framecount / framesPerFoot gauge )


fromDuration : Speed -> Gauge -> DurationInSeconds -> ( FrameCount, FootageInFeet )
fromDuration speed gauge duration =
    let
        framecount =
            duration * speedInFPS speed
    in
    ( framecount, framecount / framesPerFoot gauge )


speedInFPS : Speed -> Float
speedInFPS speed =
    case speed of
        TwentyFourFPS ->
            24


framesPerFoot : Gauge -> Float
framesPerFoot gauge =
    case gauge of
        ThirtyFive ->
            16

        TwentyEight ->
            20.5

        Sixteen ->
            40

        NinePtFive ->
            40
