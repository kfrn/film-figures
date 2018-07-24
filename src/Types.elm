module Types exposing (..)


type SystemOfMeasurement
    = Metric
    | Imperial


allSystemsOfMeasurement : List SystemOfMeasurement
allSystemsOfMeasurement =
    [ Metric, Imperial ]


type Gauge
    = Seventy
    | ThirtyFive
    | ThirtyFiveThreePerf
    | ThirtyFiveTwoPerf
    | TwentyEight
    | SeventeenPtFive
    | Sixteen
    | NinePtFive
    | SuperEight
    | Eight


allGauges : List Gauge
allGauges =
    [ Seventy, ThirtyFive, ThirtyFiveThreePerf, ThirtyFiveTwoPerf, TwentyEight, SeventeenPtFive, Sixteen, NinePtFive, SuperEight, Eight ]


type Control
    = FootageControl
    | DurationControl
    | FrameCountControl


type alias ControlInFocus =
    Control


allControls : List Control
allControls =
    [ FootageControl, DurationControl, FrameCountControl ]


type alias Footage =
    Float


type alias DurationInSeconds =
    Float


type alias FrameCount =
    Float


type Speed
    = SixteenFPS
    | EighteenFPS
    | TwentyFourFPS
    | TwentyFiveFPS
    | NtscFPS


allSpeeds : List Speed
allSpeeds =
    [ SixteenFPS, EighteenFPS, TwentyFourFPS, TwentyFiveFPS, NtscFPS ]


type alias FootageInFeet =
    Float


type alias FootageInMetres =
    Float
