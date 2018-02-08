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
            , describe "gauge = 35mm, footage = 576', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS ThirtyFive 576
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 384
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
            , describe "gauge = 9.5mm, footage = 250', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS NinePtFive 250
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 416.667)
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
            , describe "gauge = 28mm, footage = 120', speed = 24fps" <|
                let
                    ( duration, frameCount ) =
                        fromFootage TwentyFourFPS TwentyEight 120
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 102.5
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 2460
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
            , describe "gauge = 16mm, frame count = 1840, speed = 24fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount TwentyFourFPS Sixteen 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 76.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 46
                ]
            , describe "gauge = 9.5mm, frame count = 1840, speed = 24fps" <|
                let
                    ( duration, footage ) =
                        fromFrameCount TwentyFourFPS NinePtFive 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 76.667)
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
            , describe "gauge = 16mm, duration = 30 seconds, speed = 24fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFourFPS Sixteen 30
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 720
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 18
                ]
            , describe "gauge = 16mm, duration = 576 seconds, speed = 24fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFourFPS Sixteen 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 13824
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 345.6
                ]
            , describe "gauge = 9.5mm, duration = 576 seconds, speed = 24fps" <|
                let
                    ( frameCount, footage ) =
                        fromDuration TwentyFourFPS NinePtFive 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 13824
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 345.6
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
            ]
        ]
