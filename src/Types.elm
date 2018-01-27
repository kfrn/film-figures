module Types exposing (..)


type SystemOfMeasurement
    = Metric
    | Imperial


allSystemsOfMeasurement : List SystemOfMeasurement
allSystemsOfMeasurement =
    [ Metric, Imperial ]


type Gauge
    = ThirtyFive
    | Sixteen


allGauges : List Gauge
allGauges =
    [ ThirtyFive, Sixteen ]


type Control
    = LengthControl
    | DurationControl
    | FrameCountControl


allControls : List Control
allControls =
    [ LengthControl, DurationControl, FrameCountControl ]
