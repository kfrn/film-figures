module Update exposing (Msg(..), update)

import Model exposing (Model)
import Translate exposing (Language(..))


type Msg
    = ChangeLanguage Language
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLanguage l ->
            ( { model | language = l }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
