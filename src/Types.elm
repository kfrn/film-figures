module Types exposing (..)


type SystemOfMeasurement
    = Metric
    | Imperial


allSystemsOfMeasurement : List SystemOfMeasurement
allSystemsOfMeasurement =
    [ Metric, Imperial ]


type Gauge
    = ThirtyFive
    | TwentyEight
    | Sixteen
    | NinePtFive


allGauges : List Gauge
allGauges =
    [ ThirtyFive, TwentyEight, Sixteen, NinePtFive ]


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


type Speed
    = TwentyFourFPS
