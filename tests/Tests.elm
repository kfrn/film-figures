module Tests exposing (..)

import Calculate exposing (fromDuration, fromFootage, fromFrameCount)
import Expect
import Round
import Test exposing (..)
import Types exposing (..)


all : Test
all =
    describe "Basic calculations"
        [ describe "calculate duration and framecount from footage" <|
            [ describe "gauge = 35mm and footage = 4'" <|
                let
                    ( duration, frameCount ) =
                        fromFootage ThirtyFive 4
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 2.667)
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 64
                ]
            , describe "gauge = 35mm and footage = 576'" <|
                let
                    ( duration, frameCount ) =
                        fromFootage ThirtyFive 576
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 384
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 9216
                ]
            , describe "gauge = 16mm and footage = 250'" <|
                let
                    ( duration, frameCount ) =
                        fromFootage Sixteen 250
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal (Round.round 3 duration) (toString 416.667)
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 10000
                ]
            , describe "gauge = 35mm and footage is 180'" <|
                let
                    ( duration, frameCount ) =
                        fromFootage ThirtyFive 180
                in
                [ test "duration is correct" <|
                    \_ ->
                        Expect.equal duration 120
                , test "framecount is correct" <|
                    \_ ->
                        Expect.equal frameCount 2880
                ]
            ]
        , describe "calculate duration and footage from frame count" <|
            [ describe "gauge = 35mm and frame count = 400" <|
                let
                    ( duration, footage ) =
                        fromFrameCount ThirtyFive 400
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 16.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 25
                ]
            , describe "gauge = 16mm and frame count = 400" <|
                let
                    ( duration, footage ) =
                        fromFrameCount Sixteen 400
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 16.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 10
                ]
            , describe "gauge = 16mm and frame count = 1840" <|
                let
                    ( duration, footage ) =
                        fromFrameCount Sixteen 1840
                in
                [ test "duration is correct" <|
                    \_ -> Expect.equal (Round.round 3 duration) (toString 76.667)
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 46
                ]
            ]
        , describe "calculate frame count and footage from duration" <|
            [ describe "gauge = 35mm and duration = 80 seconds" <|
                let
                    ( frameCount, footage ) =
                        fromDuration ThirtyFive 80
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 1920
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 120
                ]
            , describe "gauge = 16mm and duration = 30 seconds" <|
                let
                    ( frameCount, footage ) =
                        fromDuration Sixteen 30
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 720
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 18
                ]
            , describe "gauge = 16mm and duration = 576 seconds" <|
                let
                    ( frameCount, footage ) =
                        fromDuration Sixteen 576
                in
                [ test "frame count is correct" <|
                    \_ -> Expect.equal frameCount 13824
                , test "footage is correct" <|
                    \_ -> Expect.equal footage 345.6
                ]
            ]
        ]
