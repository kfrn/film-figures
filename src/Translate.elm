module Translate exposing (..)


type Language
    = EN
    | FR
    | IT


allLanguages : List Language
allLanguages =
    [ EN, FR, IT ]


type AppString
    = ChooseStr
    | DevelopedByStr
    | FeetStr
    | FramesStr
    | ImperialStr
    | MetresStr
    | MetricStr
    | SecondsStr
    | SetOptionStr
    | TaglineStr


translate : Language -> AppString -> String
translate language appString =
    let
        translationSet =
            case appString of
                ChooseStr ->
                    { en = "Choose a gauge and a speed:"
                    , fr = "Choisir un format et une vitesse:"
                    , it = "Scegliere un formato e una velocità:"
                    }

                DevelopedByStr ->
                    { en = "Web app by K F Nagels"
                    , fr = "Application web par K F Nagels"
                    , it = "Applicazione web di K F Nagels"
                    }

                FeetStr ->
                    { en = "feet"
                    , fr = "pieds"
                    , it = "piedi"
                    }

                FramesStr ->
                    { en = "frames"
                    , fr = "cadres"
                    , it = "fotogramme"
                    }

                ImperialStr ->
                    { en = "imperial"
                    , fr = "impérial"
                    , it = "imperiale"
                    }

                MetresStr ->
                    { en = "metres"
                    , fr = "mètres"
                    , it = "metri"
                    }

                MetricStr ->
                    { en = "metric"
                    , fr = "métrique"
                    , it = "metrico"
                    }

                SecondsStr ->
                    { en = "seconds"
                    , fr = "secondes"
                    , it = "secondi"
                    }

                SetOptionStr ->
                    { en = "Set one of the following:"
                    , fr = "Définissez une option:"
                    , it = "Imposta un'opzione:"
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
