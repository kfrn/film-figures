module Calculate exposing (..)

import Types exposing (..)


fromFootage : SystemOfMeasurement -> Speed -> Gauge -> Footage -> ( DurationInSeconds, FrameCount )
fromFootage system speed gauge footage =
    let
        frames =
            case system of
                Imperial ->
                    footage * framesPerFoot gauge

                Metric ->
                    metresToFeet footage * framesPerFoot gauge
    in
    ( frames / speedInFPS speed, frames )


fromFrameCount : SystemOfMeasurement -> Speed -> Gauge -> FrameCount -> ( DurationInSeconds, Footage )
fromFrameCount system speed gauge framecount =
    let
        footage =
            footageFromFrameCount framecount system gauge
    in
    ( framecount / speedInFPS speed, footage )


fromDuration : SystemOfMeasurement -> Speed -> Gauge -> DurationInSeconds -> ( FrameCount, Footage )
fromDuration system speed gauge duration =
    let
        framecount =
            duration * speedInFPS speed

        footage =
            footageFromFrameCount framecount system gauge
    in
    ( framecount, footage )


footageFromFrameCount : FrameCount -> SystemOfMeasurement -> Gauge -> Footage
footageFromFrameCount frames system gauge =
    case system of
        Imperial ->
            frames / framesPerFoot gauge

        Metric ->
            feetToMetres <| frames / framesPerFoot gauge


speedInFPS : Speed -> Float
speedInFPS speed =
    case speed of
        SixteenFPS ->
            16

        EighteenFPS ->
            18

        TwentyFourFPS ->
            24

        TwentyFiveFPS ->
            25

        NtscFPS ->
            30 / 1.001


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

        SuperEight ->
            72

        Eight ->
            80


feetToMetres : FootageInFeet -> FootageInMetres
feetToMetres feet =
    feet * 0.3048


metresToFeet : FootageInMetres -> FootageInFeet
metresToFeet metres =
    metres * 3.28
