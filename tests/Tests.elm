module Tests exposing (..)

import Calculate exposing (fromDuration, fromFootage, fromFrameCount)
import Expect
import Round
import Test exposing (..)
import Types exposing (..)


all : Test
all =
    describe "Basic calculations"
        [ describe "calculate duration, framecount from footage" <|
            [ describe "gauge = 35mm, footage = 4', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS ThirtyFive 4
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 2.667)
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 64
                ]
            , describe "gauge = 35mm, footage = 576', speed = 25fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFiveFPS ThirtyFive 576
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 368.64
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 9216
                ]
            , describe "gauge = 16mm, footage = 250', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS Sixteen 250
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 416.667)
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 10000
                ]
            , describe "gauge = 9.5mm, footage = 250', speed = 16fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage SixteenFPS NinePtFive 250
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 625
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 10000
                ]
            , describe "gauge = 35mm, footage = 180', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS ThirtyFive 180
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 120
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 2880
                ]
            , describe "gauge = 28mm, footage = 120', speed = 18fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage EighteenFPS TwentyEight 120
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 136.667)
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 2460
                ]
            , describe "gauge = Super-8, footage = 200', speed = 18fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage EighteenFPS SuperEight 200
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 800
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 14400
                ]
            , describe "gauge = 8mm, footage = 25', speed = 16fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage SixteenFPS Eight 25
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 125
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 2000
                ]
            ]
        , describe "calculate duration, footage from frame count" <|
            [ describe "gauge = 35mm, frame count = 400, speed = 24fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount TwentyFourFPS ThirtyFive 400
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 16.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 25
                ]
            , describe "gauge = 16mm, frame count = 400, speed = 24fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount TwentyFourFPS Sixteen 400
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 16.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 10
                ]
            , describe "gauge = 16mm, frame count = 1840, speed = 29.97fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount NtscFPS Sixteen 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 61.395)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 46
                ]
            , describe "gauge = 9.5mm, frame count = 1840, speed = 16fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount SixteenFPS NinePtFive 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal duration 115
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 46
                ]
            , describe "gauge = 28mm, frame count = 1840, speed = 24fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount TwentyFourFPS TwentyEight 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 76.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal (Round.round 3 footage) (toString 89.756)
                ]
            , describe "gauge = Super-8, frame count = 1840, speed = 18fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount EighteenFPS SuperEight 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 102.222)
                , test "footage is correct" <|
                    \_ -> Expect.equal (Round.round 3 footage) (toString 25.556)
                ]
            , describe "gauge = 8mm, frame count = 1840, speed = 16fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount SixteenFPS Eight 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal duration 115
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 23
                ]
            ]
        , describe "calculate frame count, footage from duration" <|
            [ describe "gauge = 35mm, duration = 80 seconds, speed = 24fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFourFPS ThirtyFive 80
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 1920
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 120
                ]
            , describe "gauge = 16mm, duration = 30 seconds, speed = 25fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFiveFPS Sixteen 30
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 750
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 18.75
                ]
            , describe "gauge = 16mm, duration = 576 seconds, speed = 29.97fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration NtscFPS Sixteen 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal (Round.round 2 frameCount) (toString 17262.74)
                , test "footage is correct" <|
                    \_ -> Expect.equal (Round.round 3 footage) (toString 431.568)
                ]
            , describe "gauge = 9.5mm, duration = 576 seconds, speed = 16fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration SixteenFPS NinePtFive 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 9216
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 230.4
                ]
            , describe "gauge = 28mm, duration = 576 seconds, speed = 24fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFourFPS TwentyEight 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 13824
                , test "footage is correct" <|
                    \_ -> Expect.equal (Round.round 3 footage) (toString 674.341)
                ]
            , describe "gauge = Super-8, duration = 576 seconds, speed = 18fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration EighteenFPS SuperEight 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 10368
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 144
                ]
            , describe "gauge = 8mm, duration = 176 seconds, speed = 16fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration SixteenFPS Eight 176
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 2816
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 35.2
                ]
            ]
        ]
