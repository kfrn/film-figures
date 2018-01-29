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
    = FootageControl
    | DurationControl
    | FrameCountControl


type alias ControlInFocus =
    Control


allControls : List Control
allControls =
    [ FootageControl, DurationControl, FrameCountControl ]


type alias FootageInFeet =
    Float


type alias DurationInSeconds =
    Float


type alias FrameCount =
    Float
