module Translate exposing (..)


type Language
    = EN
    | FR
    | IT


allLanguages : List Language
allLanguages =
    [ EN, FR, IT ]


type AppString
    = DevelopedByStr
    | TaglineStr


translate : Language -> AppString -> String
translate language appString =
    let
        translationSet =
            case appString of
                DevelopedByStr ->
                    { en = "Web app by Katherine Frances Nagels"
                    , fr = "Application web par Katherine Frances Nagels"
                    , it = "Applicazione web di Katherine Frances Nagels"
                    }

                TaglineStr ->
                    { en = "a calculator for analogue film"
                    , fr = "une calculatrice pour la pellicule"
                    , it = "un calcolatrice per la pellicola"
                    }
    in
    case language of
        EN ->
            .en translationSet

        FR ->
            .fr translationSet

        IT ->
            .it translationSet
