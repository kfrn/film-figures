module Calculate exposing (..)

import Types exposing (..)


fromFootage : Gauge -> FootageInFeet -> ( DurationInSeconds, FrameCount )
fromFootage gauge footage =
    let
        frames =
            footage * framesPerFoot gauge
    in
    ( frames / speedInFPS, frames )


fromFrameCount : Gauge -> FrameCount -> ( DurationInSeconds, FootageInFeet )
fromFrameCount gauge framecount =
    ( framecount / speedInFPS, framecount / framesPerFoot gauge )


fromDuration : Gauge -> DurationInSeconds -> ( FrameCount, FootageInFeet )
fromDuration gauge duration =
    let
        framecount =
            duration * speedInFPS
    in
    ( framecount, framecount / framesPerFoot gauge )


speedInFPS : Float
speedInFPS =
    24


framesPerFoot : Gauge -> Float
framesPerFoot gauge =
    case gauge of
        ThirtyFive ->
            16

        Sixteen ->
            40
