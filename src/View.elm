module View exposing (view)

import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]
